# IBM WebSphere Application Server Liberty Cartridge

## Usage Examples

To deploy applications using the IBM WebSphere Application Server Liberty Cartridge, you are required to accept the IBM Liberty license by following the instructions below:

1. Read the current IBM [Liberty-License][].
2. Extract the `D/N: <License code>` from the Liberty-License.
3. Set the IBM_LIBERTY_LICENSE environment variable to the extracted license code when you create your application.  

Default app example using OpenShift Origin with cartridge installed:

```bash
rhc app-create <app name> ibm-liberty-8.5.5.2 IBM_LIBERTY_LICENSE=<liberty license code>
```

Example of creating an app with a downloadable cartridge at OpenShift Online:

```bash
rhc create-app <app name> http://cartreflect-claytondev.rhcloud.com/reflect?github=opiethehokie/openshift-liberty-cartridge postgresql-9.2 -e IBM_LIBERTY_LICENSE=<liberty license code> --from-code https://github.com/opiethehokie/openshift-acmeair.git
```  

To add a WAR file to an existing app, there are three options:

1. Place it in app git repo's dropins dir, then git commit.
2. Place it in app git repo's apps directory replacing ROOT.war (or also configure server.xml for a different WAR name), then delete the default app template, then git commit.
3. scp the WAR to apps or dropins in the app's gear at liberty/servers/defaultServer and configure server.xml if necessary.


[Liberty-License]: http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/8.5.5.2/lafiles/runtime/en.html
