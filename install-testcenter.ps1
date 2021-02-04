param (
    [string]$Dir = 'c:\users\administrator\downloads',
    [int]$ExtraDownloads = 0
)

function Invoke-Download {
Param (
      [string]$Url,
      [string]$FilePath
)
        Write-Output "Downloading $FilePath"
        Invoke-WebRequest -Uri $Url -OutFile $FilePath
}

function Invoke-Installer {
Param (
      [string]$FilePath,
      [string]$ArgumentList
)
        Write-Output "Installing $FilePath"
        Start-Process -Wait  -PassThru -FilePath $FilePath -ArgumentList $ArgumentList
}

$ProgressPreference = 'SilentlyContinue'

if ( Test-Path "$Dir/Spirent TestCenter Application.exe")
{
        $stc_installer = "Spirent TestCenter Application.exe"
        $vcredists = "vcredist_x86_2008.exe", "vcredist_x86_2010.exe", `
                     "vcredist_x86_2013.exe", "vcredist_x86_2017.exe"
}
else
{
        $stc_installer = "Spirent TestCenter Application x64.exe"
        $vcredists = "vcredist_x64_2008.exe", "vcredist_x64_2010.exe", `
                     "vcredist_x64_2013.exe", "vcredist_x64_2017.exe"
}

# Install Spirent TestCenter dependencies prior to SpirentTestCenter for a silent install
#Invoke-Download -FilePath "$Dir/chrome_installer.exe" -Url "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
Invoke-Installer -FilePath "$Dir\ChromeSetup.exe" -ArgumentList "/silent /install"
foreach ( $vcredist in $vcredists)
{
        Invoke-Installer -FilePath "$Dir\$vcredist" -ArgumentList "/q"
}

# Install TestCenter
Invoke-Installer -FilePath "$Dir/$stc_installer" -ArgumentList "/silent /pgpassword:postgres"

if ( $ExtraDownloads )
{
        Invoke-Download -FilePath "$Dir/Wireshark.exe" -Url "https://2.na.dl.wireshark.org/win64/Wireshark-win64-3.4.2.exe"
        Invoke-Installer -FilePath "$Dir/Wireshark.exe" -ArgumentList "/S"
}