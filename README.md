IBM WebSphere Application Server Liberty Cartridge
==================================================

To deploy applications using the IBM WebSphere Application Server Liberty Cartridge, you are required to accept the IBM Liberty license by following the instructions below:

1. Read the current IBM [Liberty-License][].
2. Extract the `D/N: <License code>` from the Liberty-License.
3. Set the IBM_LIBERTY_LICENSE environment variable to the extracted license code when you create your application.

Default app example:

```bash
rhc app-create <app name> ibm-liberty-8.5.5 IBM_LIBERTY_LICENSE=<liberty license code>
```

App from existing source with a database example:

```bash
rhc app-create <app name> ibm-liberty-8.5.5 postgresql-9.2 --from-code git@9.37.205.4:mtpeters-us/openshift-acmeair.git --timeout 300 IBM_LIBERTY_LICENSE=<liberty license code>
```

To add a WAR file to an existing app, there are three options:

1. Place it in app git repo at servers/defaultServer/dropins, then git commit. 
2. Place it in app git repo at servers/defaultServer/apps and delete ROOT.war and configure server.xml (or just replace ROOT.war) and delete the default app template, then git commit.
3. scp the WAR to apps or dropins in the app's gear at liberty/servers/defaultServer and configure server.xml if necessary.

To install the cartridge into the Origin VM:

1. clone this repository
2. cd liberty-cartridge
3. bin/cache_liberty /path/liberty-cartridge (optional step - include Liberty in cartridge so it won't be downloaded at every app-create)
4. oo-admin-cartridge --action install --source /path/liberty-cartridge

Example of creating an app with a third-party cartridge (hopefully it would be the same for the Liberty cartridge assuming it was in a public git repo):

```bash
rhc create-app nginx http://cartreflect-claytondev.rhcloud.com/reflect?github=gsterjov/openshift-nginx-cartridge
```


[Liberty-License]: http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/8.5.5.1/lafiles/runtime//en.html
