param (
    [string]$dir = 'c:\users\administrator\downloads',
    [int]$download = 0
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

# Install Spirent TestCenter dependencies prior to SpirentTestCenter for a silent install
Invoke-Installer -FilePath "$dir\ChromeSetup.exe" -ArgumentList "/silent /install"
Invoke-Installer -FilePath "$dir\vcredist_x86_2008.exe" -ArgumentList "/q"
Invoke-Installer -FilePath "$dir\vcredist_x86_2010.exe" -ArgumentList "/q"
Invoke-Installer -FilePath "$dir\vcredist_x86_2013.exe" -ArgumentList "/q"
Invoke-Installer -FilePath "$dir\vcredist_x86_2017.exe" -ArgumentList "/q"

# Install TestCenter
Invoke-Installer -FilePath "$dir/Spirent TestCenter Application.exe" -ArgumentList "/silent /pgpassword:postgres"

if ( $download )
{
        Invoke-Download -FilePath "$dir/Wireshark.exe" -Url "https://2.na.dl.wireshark.org/win64/Wireshark-win64-3.4.2.exe"
        Invoke-Installer -FilePath "$dir/Wireshark.exe" -ArgumentList "/S"
}