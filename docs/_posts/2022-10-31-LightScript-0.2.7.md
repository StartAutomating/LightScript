---

title: LightScript 0.2.7
sourceURL: https://github.com/StartAutomating/LightScript/releases/tag/v0.2.7
tag: release
---
## 0.2.7:

* Pixoo Improvements:
  * Adding Find-Pixoo (Fixes [#46](https://github.com/StartAutomating/LightScript/issues/46))
  * Connect-Pixoo:  Carrying on DeviceID (Fixes [#50](https://github.com/StartAutomating/LightScript/issues/50))
  * Get-Pixoo:  Adding -Weather (Fixes [#51](https://github.com/StartAutomating/LightScript/issues/51))
  * Set-Pixoo:  -Rotation (Fixes [#47](https://github.com/StartAutomating/LightScript/issues/47))
  * Set-Pixoo:  Adding -Latitutde and -Longitude (Fixes [#48](https://github.com/StartAutomating/LightScript/issues/48))

---
  

## 0.2.6:
* Set-NanoLeaf:
    * Fixing -SaturationIncrement ([#35](https://github.com/StartAutomating/LightScript/issues/35))
    * Adding -BrightnessIncrement ([#34](https://github.com/StartAutomating/LightScript/issues/34))
    * Fixing -Hue/-Saturation/-Brightness behavior to allow increment parameters to work. ([#36](https://github.com/StartAutomating/LightScript/issues/36))
    * Making Parameter Aliases consistent with Set-HueLight ([#38](https://github.com/StartAutomating/LightScript/issues/38))
* Now using [GitPub](https://github.com/StartAutomating/GitPub) to blog ([#37](https://github.com/StartAutomating/LightScript/issues/37)).

---

## 0.2.5:
* Set-HueRule:  Easier conditions (Fixes [#28](https://github.com/StartAutomating/LightScript/issues/28)) and plural aliases (Fixes [#31](https://github.com/StartAutomating/LightScript/issues/31))
* Adding Rename-HueSensor (Fixes [#26](https://github.com/StartAutomating/LightScript/issues/26)).
* Rename-HueLight: Adding [Alias('ID')] to -OldName (Fixes [#27](https://github.com/StartAutomating/LightScript/issues/27))
* Get-HueBridge:  SupportShouldProcess (Fixes [#30](https://github.com/StartAutomating/LightScript/issues/30))
* Set-HueLight:  Fixing -Brightness/SaturationIncrement (Fixes [#29](https://github.com/StartAutomating/LightScript/issues/29))
* Add-HueSensor:  Adding -New (Fixes [#25](https://github.com/StartAutomating/LightScript/issues/25))
* Improved Repository Organization (Fixes [#32](https://github.com/StartAutomating/LightScript/issues/32))

---

## 0.2.4.1:
* Adding help for Add-HueLight ([#23](https://github.com/StartAutomating/LightScript/issues/23))
* Fixing other markdown documentation layout issues

---

## 0.2.4:
* Adding Add-HueLight ([#18](https://github.com/StartAutomating/LightScript/issues/18))
* Adding Get-HueLight -New ([#21](https://github.com/StartAutomating/LightScript/issues/21))
* Fixing Rename-HueLight ([#19](https://github.com/StartAutomating/LightScript/issues/19))
* Building LightScript with PipeScript ([#20](https://github.com/StartAutomating/LightScript/issues/20))

---

## 0.2.3:
* Set-NanoLeaf:  Fixing [#17](https://github.com/StartAutomating/LightScript/issues/17)
* Send-HueBridge:  Adding logging
* Automatically documentating module ([#13](https://github.com/StartAutomating/LightScript/issues/13))
* Set-HueLight:
  * Fixing Transition Time ([#12](https://github.com/StartAutomating/LightScript/issues/12))
  * Adding examples
  * Fixing -Hue/-HueIncrement ([#15](https://github.com/StartAutomating/LightScript/issues/15))   

---

## 0.2.2:
Adding KeyLight: Connect-KeyLight, Get-KeyLight, Set-KeyLight, Disconnect-KeyLight

---

## 0.2.1:
* Set-NanoLeaf:  Adding -EffectOption parameter help ([#9](https://github.com/StartAutomating/LightScript/issues/9)).  Adding examples.
* Set-NanoLeaf:  Fixing Brightness ([#7](https://github.com/StartAutomating/LightScript/issues/7)).  Adding Tab Completion ([#8](https://github.com/StartAutomating/LightScript/issues/8)).  Adding Examples

---

## 0.2:
Adding: Disconnect-HueBridge, Disconnect-NanoLeaf, Disconnect-Twinkly ([#2](https://github.com/StartAutomating/LightScript/issues/2))
Adding Pixoo commands: Connect/Disconnect/Get/Set-Pixoo ([#4](https://github.com/StartAutomating/LightScript/issues/4))

---

## 0.1:
Initial Release of LightScript:  Smarter Lighting with PowerShell

Script your Hue Bridge, NanoLeaf, or Twinkly lights.
