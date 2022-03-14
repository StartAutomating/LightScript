@{
    ModuleVersion = '0.2'
    RootModule = 'LightScript.psm1'
    Description = 'Smarter Lighting with PowerShell'
    FormatsToProcess = 'LightScript.format.ps1xml'
    TypesToProcess = 'LightScript.types.ps1xml'
    Guid = '5ab252fe-0783-46c5-a0ac-a9d62c9f9615'
    Author = 'James Brundage'
    Copyright = '2021 Start-Automating'
    PrivateData = @{
        PSData = @{
            Tags = 'IoT','Hue', 'Twinkly', 'NanoLeaf'
            ProjectURI = 'https://github.com/StartAutomating/LightScript'
            LicenseURI = 'https://github.com/StartAutomating/LightScript/blob/main/LICENSE'
            IconURI    = 'https://github.com/StartAutomating/LightScript/blob/main/Assets/LightScript.png'
            ReleaseNotes = @'
## 0.2:
Adding: Disconnect-HueBridge, Disconnect-NanoLeaf, Disconnect-Twinkly (#2)
Adding Pixoo commands: Connect/Disconnect/Get/Set-Pixoo (#4)

---
## 0.1:
Initial Release of LightScript:  Smarter Lighting with PowerShell

Script your Hue Bridge, NanoLeaf, or Twinkly lights.
'@
        }
    }
}
