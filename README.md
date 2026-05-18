# Windows Bloat Purge

A PowerShell script for removing pre-installed Windows bloatware, disabling telemetry, and cleaning up unnecessary features on Windows 10/11 machines.

---

## What It Does

### Appx Package Removal
Removes and deprovisions the following built-in apps so they don't reinstall for new users:

- Cortana, Bing Weather, Bing Search
- Xbox app, Xbox Game Bar, Xbox Identity Provider
- Microsoft Store, Store Purchase App
- Office Hub, OneNote (Store version)
- Skype, Your Phone, People
- Mixed Reality Portal, 3D Viewer
- Solitaire Collection, Sticky Notes, Alarms, Camera, Sound Recorder, Maps, Feedback Hub
- Groove Music, Movies & TV
- Screen Sketch, VP9 Video Extensions

### Privacy & Telemetry
- Disables the Windows Advertising ID
- Turns off all telemetry (`AllowTelemetry = 0`) across all three policy paths
- Stops and disables the **DiagTrack** (Diagnostics Tracking) service
- Disables Windows Feedback Experience and anonymous data collection
- Disables Location Tracking

### Search & Cortana
- Disables Cortana integration in Windows Search
- Disables Bing web search in the Start Menu
- Hides the search box from the taskbar

### Bloat Prevention
- Sets registry keys to prevent OEM/Microsoft pre-installed apps from returning
- Disables silent app installs and Start Menu suggestions/Content Delivery
- Disables live tile notifications

### Miscellaneous
- Disables Wi-Fi Sense (auto-connect to hotspots and reporting)
- Removes the People icon from the taskbar
- Removes News/Feeds from the taskbar
- Disables unnecessary scheduled tasks: `XblGameSaveTask`, `Consolidator`, `UsbCeip`, `DmClient`, `DmClientOnScenarioDownload`
- Prepares Mixed Reality Portal for clean uninstall via Settings

---

## Usage

Run as **Administrator** in PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\BloatPurge.ps1
```

---

## Notes

- `$ErrorActionPreference = 'SilentlyContinue'` is set globally — the script will not throw errors for packages that are already removed or registry keys that don't exist.
- Appx packages are removed both for the current user and deprovisioned so they don't reinstall for new user profiles.
- Some changes (search box, People icon, live tiles) apply to the current user's registry hive (`HKCU`). For new profiles, consider applying via Default User hive or GPO.
- Tested on Windows 10. Most items apply to Windows 11 as well, though some taskbar registry keys may behave differently.
