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
| &nbsp;&nbsp;&nbsp;&nbsp;action_hooks/ | &nbsp;&nbsp;&nbsp;&nbsp;See the action hooks documentation
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
| disable_auto_scaling | Disables the auto-scaling provided by OpenShift


## Environment Variables

| Variable                    | Description    
| --------------------------- | ----------------------------------------
| OPENSHIFT_LIBERTY_IP        | The IP address used to bind Liberty
| OPENSHIFT_LIBERTY_HTTP_PORT | The Liberty listening port

For more information about environment variables, consult the Users Guide.


## Installing the Cartridge to OpenShift Origin

1. git clone <cartridge URL>
2. oo-admin-cartridge --action install --source /path/openshift-liberty-cartridge
3. rhc cartridges


## rhc Examples

Default app example using OpenShift Origin with cartridge installed:

```bash
rhc app-create <app name> ibm-liberty-8.5.5.2 IBM_LIBERTY_LICENSE=<liberty license code>
```

Example of creating an app (AcmeAir fork) with a downloadable cartridge at OpenShift Online:

```bash
rhc create-app <app name> http://cartreflect-claytondev.rhcloud.com/reflect?github=opiethehokie/openshift-liberty-cartridge postgresql-9.2 -e IBM_LIBERTY_LICENSE=<liberty license code> --from-code https://github.com/opiethehokie/openshift-acmeair.git
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

TBD


[Liberty-License]: http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/8.5.5.2/lafiles/runtime/en.html
