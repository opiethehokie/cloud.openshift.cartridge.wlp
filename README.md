#IBM WebSphere Application Server Liberty Cartridge

The liberty-cartridge is an OpenShift cartridge for running applications on IBM's WebSphere Application Server Liberty Profile.

##Usage

To deploy applications using the IBM WebSphere Application Server Liberty Cartridge, you are required to accept the IBM Liberty license by following the instructions below:

1. Read the current IBM [Liberty-License][].
2. Extract the `D/N: <License code>` from the Liberty-License.
3. Set the IBM_LIBERTY_LICENSE environment variable to the extracted license code when you create your application.

For example:

```bash
rhc app-create <app name> bparees-liberty-8.5.5 IBM_LIBERTY_LICENSE=<liberty license code>
```

[Liberty-License]: http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/8.5.5.1/lafiles/runtime//en.html
