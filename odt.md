The script for installing Office is different.

Before the installation, user is prompt to choose their preferences for Office, which programs to install. By the default 3 apps are selected are Word, Excel, Power Point.

If an app is selected, the line `<ExcludeApp ID="{selected app}" />` will not be generated in the `cfg.xml` config file so that ODT doesn't exclude them in the the installation. 

After checking desired app, user can click install. It will run as follow

First, check for Office Deployment Tool existence in `%ProgramFiles%\OfficeDeploymentTool` If not installed, install it via `winget install -e --id Microsoft.OfficeDeploymentTool`

Then create a `cfg.xml` config file in directory `%ProgramFiles%\OfficeDeploymentTool` with the following content, remember user preferences have chosen earlier and generate the script accordingly.

```xml
<Configuration ID="fa7d3c5b-dcdb-4abd-99f1-d60d307c651c">
  <Add Path="C:\Program Files\OfficeDeploymentTool" OfficeClientEdition="64" Channel="Current">
    <Product ID="O365ProPlusEEANoTeamsRetail">
      <Language ID="en-us" />
      <Language ID="vi-vn" />
      <ExcludeApp ID="Word" />
      <ExcludeApp ID="Excel" />
      <ExcludeApp ID="Power Point" />
      <ExcludeApp ID="Access" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="OneDrive" />
      <ExcludeApp ID="OneNote" />
      <ExcludeApp ID="Outlook" />
      <ExcludeApp ID="Publisher" />
      <ExcludeApp ID="Bing" />
    </Product>
    <Product ID="ProofingTools">
      <Language ID="vi-vn" />
    </Product>
  </Add>
  <Updates Enabled="TRUE" />
  <RemoveMSI />
  <Display Level="Full" AcceptEULA="TRUE" />
</Configuration>
```

Then it need to run `./setup.exe /configure cfg.xml` in the `%ProgramFiles%\OfficeDeploymentTool` directory in Powershell under Admin privileges.




Ok, now add a notice below the office install button telling user to run the MAS script below.

Have a button to run this script `setup-script\windows\3rd-party\MAS_AIO.cmd`. Guide user to choose [2] for Office Activation, then [1] for Ohook, and finally [0] to exit.



Now translate the UI to Vietnamese, have a toggle to switch between English and Vietnamese. 



Let user have an option to install Vietnamese of Office or not, default is no. If check add this line back <Language ID="vi-vn" /> to the cfg.xml file. If no just remove it. 