#no errors throughout
$ErrorActionPreference = 'silentlycontinue'

@(
"Microsoft.549981C3F5F10"
"Microsoft.BingWeather"
"Microsoft.DesktopAppInstaller" 
"Microsoft.GetHelp"
"Microsoft.Getstarted"
"Microsoft.Microsoft3DViewer"
"Microsoft.MicrosoftOfficeHub"
"Microsoft.MicrosoftSolitaireCollection"
"Microsoft.MicrosoftStickyNotes"
"Microsoft.MixedReality.Portal"
"Microsoft.Office.Onenote"
"Microsoft.People"
"Microsoft.ScreenSketch"
"Microsoft.SkypeApp"
"Microsoft.StorePurchaseApp"
"Microsoft.VP9VideoExtensions"
"Microsoft.WindowsAlarms"
"Microsoft.WindowsCamera"
"microsoft.windowscommunicationsapps"
"Microsoft.WindowsFeedbackHub"
"Microsoft.WindowsMaps"
"Microsoft.WindowsSoundRecorder"
"Microsoft.WindowsStore"
"Microsoft.Xbox.TCUI"
"Microsoft.XboxApp"
"Microsoft.XboxGameOverlay"
"Microsoft.XboxGamingOverlay"
"Microsoft.XboxIdentityProvider"
"Microsoft.XboxSpeechToTextOverlay"
"Microsoft.YourPhone"
"Microsoft.ZuneMusic"
"Microsoft.ZuneVideo"
) | % {
  Get-AppxPackage -Name $_| Remove-AppxPackage
  Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $_ | Remove-AppxProvisionedPackage -Online
}

#Disables Windows Feedback Experience
Write-Output "Disabling Windows Feedback Experience program"
$Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
If (Test-Path $Advertising) {
    Set-ItemProperty $Advertising Enabled -Value 0 
}
        
#Stops Cortana from being used as part of your Windows Search Function
Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
$SearchLoc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
If (!(Test-Path $SearchLoc)) {
    New-Item $SearchLoc
}

Set-ItemProperty $SearchLoc AllowCortana -Value 0 
Set-ItemProperty $SearchLoc DisableWebSearch -Value 1

Write-Output "Disabling Bing Search in Start Menu"
$HKCUSearch = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
Set-ItemProperty $HKCUSearch BingSearchEnabled -Value 0 

Write-Output "Disabling Search in TaskBar"
Set-ItemProperty $HKCUSearch SearchboxTaskbarMode -Value 0 
Set-ItemProperty $HKCUSearch TraySearchBoxVisible -Value 0 
Set-ItemProperty $HKCUSearch TraySearchBoxVisibleOnAnyMonitor -Value 0 

#Stops the Windows Feedback Experience from sending anonymous data
Write-Output "Stopping the Windows Feedback Experience program"
$Period = "HKCU:\Software\Microsoft\Siuf\Rules"
If (!(Test-Path $Period)) { 
    New-Item $Period
}
Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

#Prevents bloatware applications from returning and removes Start Menu suggestions               
Write-Output "Adding Registry key to prevent bloatware apps from returning"
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
If (!(Test-Path $registryPath)) { 
    New-Item $registryPath
}
Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

If (!(Test-Path $registryOEM)) {
    New-Item $registryOEM
}
Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          

#Preping mixed Reality Portal for removal    
Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
$Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
If (Test-Path $Holo) {
    Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
}

#Disables Wi-fi Sense
Write-Output "Disabling Wi-Fi Sense"
$WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
$WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
$WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
If (!(Test-Path $WifiSense1)) {
    New-Item $WifiSense1
}
Set-ItemProperty $WifiSense1  Value -Value 0 
If (!(Test-Path $WifiSense2)) {
    New-Item $WifiSense2
}
Set-ItemProperty $WifiSense2  Value -Value 0 
Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
    
#Disables live tiles
Write-Output "Disabling live tiles"
$Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
If (!(Test-Path $Live)) {      
    New-Item $Live
}
Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
    
#Turns off Data Collection via the AllowTelemtry key by changing it to 0
Write-Output "Turning off Data Collection"
$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
$DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
If (Test-Path $DataCollection1) {
    Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection2) {
    Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection3) {
    Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
}

#Disabling Location Tracking
Write-Output "Disabling Location Tracking"
$SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
$LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
If (!(Test-Path $SensorState)) {
    New-Item $SensorState
}
Set-ItemProperty $SensorState SensorPermissionState -Value 0 
If (!(Test-Path $LocationConfig)) {
    New-Item $LocationConfig
}
Set-ItemProperty $LocationConfig Status -Value 0 
    
#Disables People icon on Taskbar
Write-Output "Disabling People icon on Taskbar"
$People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
If (Test-Path $People) {
    Set-ItemProperty $People -Name PeopleBand -Value 0
}
    
#Disables scheduled tasks that are considered unnecessary 
Write-Output "Disabling scheduled tasks"
Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
Get-ScheduledTask  Consolidator | Disable-ScheduledTask
Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
Get-ScheduledTask  DmClient | Disable-ScheduledTask
Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask

Write-Output "Stopping and disabling Diagnostics Tracking Service"
#Disabling the Diagnostics Tracking Service
Stop-Service "DiagTrack"
Set-Service "DiagTrack" -StartupType Disabled

Write-Output "Removing News on taskbar"
$NewsFeedLoc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds'
If (!(Test-Path $NewsFeedLoc)) {
    New-Item $NewsFeedLoc
}
Set-ItemProperty $NewsFeedLoc EnableFeeds -Value 0
