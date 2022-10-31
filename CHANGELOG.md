## 0.2.7:

* Pixoo Improvements:
  * Adding Find-Pixoo (Fixes #46)
  * Connect-Pixoo:  Carrying on DeviceID (Fixes #50)
  * Get-Pixoo:  Adding -Weather (Fixes #51)
  * Set-Pixoo:  -Rotation (Fixes #47)
  * Set-Pixoo:  Adding -Latitutde and -Longitude (Fixes #48)

---
  

## 0.2.6:
* Set-NanoLeaf:
    * Fixing -SaturationIncrement (#35)
    * Adding -BrightnessIncrement (#34)
    * Fixing -Hue/-Saturation/-Brightness behavior to allow increment parameters to work. (#36)
    * Making Parameter Aliases consistent with Set-HueLight (#38)
* Now using [GitPub](https://github.com/StartAutomating/GitPub) to blog (#37).

---

## 0.2.5:
* Set-HueRule:  Easier conditions (Fixes #28) and plural aliases (Fixes #31)
* Adding Rename-HueSensor (Fixes #26).
* Rename-HueLight: Adding [Alias('ID')] to -OldName (Fixes #27)
* Get-HueBridge:  SupportShouldProcess (Fixes #30)
* Set-HueLight:  Fixing -Brightness/SaturationIncrement (Fixes #29)
* Add-HueSensor:  Adding -New (Fixes #25)
* Improved Repository Organization (Fixes #32)

---

## 0.2.4.1:
* Adding help for Add-HueLight (#23)
* Fixing other markdown documentation layout issues

---

## 0.2.4:
* Adding Add-HueLight (#18)
* Adding Get-HueLight -New (#21)
* Fixing Rename-HueLight (#19)
* Building LightScript with PipeScript (#20)

---

## 0.2.3:
* Set-NanoLeaf:  Fixing #17
* Send-HueBridge:  Adding logging
* Automatically documentating module (#13)
* Set-HueLight:
  * Fixing Transition Time (#12)
  * Adding examples
  * Fixing -Hue/-HueIncrement (#15)   

---

## 0.2.2:
Adding KeyLight: Connect-KeyLight, Get-KeyLight, Set-KeyLight, Disconnect-KeyLight

---

## 0.2.1:
* Set-NanoLeaf:  Adding -EffectOption parameter help (#9).  Adding examples.
* Set-NanoLeaf:  Fixing Brightness (#7).  Adding Tab Completion (#8).  Adding Examples

---

## 0.2:
Adding: Disconnect-HueBridge, Disconnect-NanoLeaf, Disconnect-Twinkly (#2)
Adding Pixoo commands: Connect/Disconnect/Get/Set-Pixoo (#4)

---

## 0.1:
Initial Release of LightScript:  Smarter Lighting with PowerShell

Script your Hue Bridge, NanoLeaf, or Twinkly lights.