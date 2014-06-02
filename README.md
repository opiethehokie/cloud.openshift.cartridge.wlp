# IBM WebSphere Application Server Liberty Cartridge

Provides the Liberty server on OpenShift.


## Accepting the Liberty License

To deploy applications using the IBM WebSphere Application Server Liberty Cartridge, you are required to accept the IBM Liberty license by following the instructions below:

1. Read the current IBM [Liberty-License][].
2. Extract the `D/N: <License code>` from the Liberty-License.
3. Set the IBM_LIBERTY_LICENSE environment variable to the extracted license code when you create your application (this must be done using the rhc command-line client because the web UI does not provide a way). 


## Template Repository Layout

| File                                  | Purpose
| ------------------------------------- | --------------------------------------------------------------
| apps/ (optional)                      | Location for built applications with server configuartion
| dropins/ (optional)                   | Location for built applications without server configuration
| src/                                  | Example Maven source structure
| pom.xml                               | Example Maven build file
| .openshift/ (optional)                | Location for OpenShift specific files
| &nbsp;&nbsp;&nbsp;&nbsp;config/       | &nbsp;&nbsp;&nbsp;&nbsp;Location for Liberty configuration files
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;server.xml | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Server configuration
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bootstrap.properties | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Server bootstrap properties
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jvm.options | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JVM options
| &nbsp;&nbsp;&nbsp;&nbsp;action_hooks/ | &nbsp;&nbsp;&nbsp;&nbsp;See the [action hooks documentation][]
| &nbsp;&nbsp;&nbsp;&nbsp;markers/      | &nbsp;&nbsp;&nbsp;&nbsp;See the Markers section below


## Layout and Deployment Options

There are two options for deploying applications on Liberty in OpenShift. They can be used together.

### Method 1

You can upload your content in a Maven src structure as is this sample project and on git push have the application built and deployed. For this to work you'll need your pom.xml at the root of your repository and a maven-war-plugin like in this sample to move the output from the build to the apps/ or dropins/ directories. By default the warName is ROOT within pom.xml, the WAR is moved to apps/, and the context-root is /.

A WAR in apps/ needs to be configured in server.xml (where the context-root is configurable), see sample pom.xml and server.xml. A WAR in dropins/ does not need any additional configuration and the context-root for a file app_name.war will be /app_name.

### Method 2

You can git push pre-built wars into apps/ or dropins/. To do this with the default repo you'll want to first run "git rm -r src/ pom.xml" from the root of your repo.

Basic workflows for deploying pre-built content (each operation will require associated git add/commit/push operations to take effect):

1. Add new zipped content and deploy it: cp target/example.war dropins/

2. Undeploy currently deployed content: git rm dropins/example.war

3. Add new zipped content and deploy it with specific configuration:

  a. cp target/example.war apps/
   
  b. edit server.xml for example.war


## Markers

Adding marker files to .openshift/markers will have the following effects:

| Marker               | Effect
| -------------------- | --------------------------------------------------
| enable_jpda          | Enable remote debug of code running inside the Liberty server.
| skip_maven_build     | Maven build step will be skipped.
| force_clean_build    | Will start the build process by removing all non-essential Maven dependencies. Any current dependencies specified in your pom.xml file will then be re-downloaded.
| hot_deploy           | Will prevent a Liberty container restart during build/deployment.
| disable_auto_scaling | Disables the auto-scaling provided by OpenShift.


## Environment Variables

| Variable                    | Description    
| --------------------------- | ----------------------------------------
| OPENSHIFT_LIBERTY_IP        | The IP address used to bind Liberty
| OPENSHIFT_LIBERTY_HTTP_PORT | The Liberty listening port

For more information about environment variables, consult the [environment variable documentation][].


## Installing the Cartridge to OpenShift Origin

1. git clone <cartridge URL>
2. oo-admin-cartridge --action install --source /path/openshift-liberty-cartridge
3. rhc cartridges


## rhc Examples

See the [User Guide][] for more details.

Default app example using OpenShift Origin with cartridge installed:

```bash
rhc app-create <app name> ibm-liberty-8.5.5 IBM_LIBERTY_LICENSE=<liberty license code>
```

Example of creating a scalable app (AcmeAir fork) with a downloadable cartridge at OpenShift Online:

```bash
rhc create-app <app name> http://cartreflect-claytondev.rhcloud.com/reflect?github=opiethehokie/openshift-liberty-cartridge postgresql-9.2 -s -e IBM_LIBERTY_LICENSE=<liberty license code> --from-code https://github.com/opiethehokie/openshift-acmeair.git --timeout 600
```

Examples of tailing app logs:

```bash
rhc tail --opts "-n 50"
rhc tail -f <app name>/log/ffdc/*
```

Example of triggering and viewing a thread dump:

```bash
rhc threaddump
rhc tail -f <app name>/log/threaddump.out
```


## Developing an Application in Eclipse

See [Getting started with PaaS Eclipse integration][]. If you are using OpenShift Online this cartridge will not be available when you are creating an app in Eclipse. Create the app with rhc then use the existing application in Eclipse.

JBoss Tools can co-exist with with WebSphere Development Tools (WDT). The port-forwarding provided by OpenShift provides a way to run the app locally on Liberty while still using your databases in the cloud, or remotely debug an app running in the cloud.


## Remote JMX Connections

For the simplest configuration that will work, add the following to your server.xml (replacing "user" and "pass" with your own values):

```xml
<features>
    <feature>restConnector-1.0</feature>
</features>

<quickStartSecurity userName="user" userPassword="pass"/>

<keyStore id="defaultKeyStore" password="Liberty"/>

<webContainer httpsIndicatorHeader="X-Forwarded-Proto" />
```

This loads the server's JMX REST connector, sets the server's keystore, creates a single administrator user role, and sets the header that indicates a HTTPS connection (because SSL is terminated before the application). See [Configuring secure JMX connection to the Liberty profile][] for more detailed documentation. 

Then run the following commands (replacing the values in <>):

```bash
rhc scp <app name> download <local dir> <app name>/servers/defaultServer/resources/security/key.jks
rhc port-forward
jconsole -J-Djava.class.path="%JAVA_HOME%/lib/jconsole.jar;%JAVA_HOME%/lib/tools.jar;%WLP_HOME%/clients/restConnector.jar" -J-Dcom.ibm.ws.jmx.connector.client.disableURLHostnameVerification=true -J-Djavax.net.ssl.trustStore=<local path>/key.jks -J-Djavax.net.ssl.trustStorePassword=Liberty -J-Djavax.net.ssl.trustStoreType=jks
```

The URL JConsole is looking for will then be service:jmx:rest://localhost:port/IBMJMXConnectorREST (get port value from rhc port-forward output, the default is 9443) and the user and password are the values you added to your server.xml.

If the application is scaled you can list the gears with "rhc app show \<app name\> --gears". Then for the secondary gears you'll have to use regular scp (not rhc scp) to get key.jks from the listed SSH URL and use "rhc port-forward -g \<gear id\>".


[Liberty-License]: http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/8.5.5.2/lafiles/runtime/en.html
[Getting started with PaaS Eclipse integration]: https://www.openshift.com/blogs/getting-started-with-eclipse-paas-integration
[environment variable documentation]: http://openshift.github.io/documentation/oo_user_guide.html#environment-variables
[action hooks documentation]: http://openshift.github.io/documentation/oo_user_guide.html#action-hooks
[User Guide]: http://openshift.github.io/documentation/oo_user_guide.html
[Configuring secure JMX connection to the Liberty profile]: http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_admin_restconnector.html?cp=SSAW57_8.5.5%2F1-3-11-0-3-3-9-1&lang=en
