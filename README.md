# IBM WebSphere Application Server Liberty Cartridge

Provides the Liberty server on OpenShift using the IBM WebSphere Application Server Liberty Buildpack for Cloud Foundry.


## Accepting the Liberty License

To deploy applications using the IBM WebSphere Application Server Liberty Cartridge, you are required to accept the IBM Liberty license by following the instructions below:

1. Read the current IBM [Liberty-License][].
2. Extract the `D/N: <License code>` from the Liberty-License.
3. Set the IBM_LIBERTY_LICENSE environment variable to the extracted license code when you create your application (this must be done using the rhc command-line client because the web UI does not provide a way). 


[Liberty-License]: http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/8.5.5.2/lafiles/runtime/en.html
