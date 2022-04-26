param(
[int]
$ColorTemperature
)


if ($ColorTemperature -lt 1200) {
    $ColorTemperature = (1000000/$ColorTemperature)
}

$ct100 = $ColorTemperature / 100

$red, $green = 
    if ($ct100 -le 66) {
        255 # red
        [Math]::Round([Math]::Min([Math]::Max(
            (99.4708025861 * [Math]::Log($ct100)) - 161.1195681661,
            0
        ), 255))
    } else {    
        # red
        [Math]::Round([Math]::Min([Math]::Max(
            329.698727446 * [Math]::Pow($ct100 - 60,-0.1332047592),
            0
        ), 255))
        # green
        [Math]::Round([Math]::Min([Math]::Max(
            288.1221695283 * [Math]::Pow($ct100 - 60,-0.0755148492),
            0
        ), 255))        
    }

$blue =
    if ($ct100 -ge 66) {
        255
    } elseif ($ct100 -le 19) {
        0
    } else {
        [Math]::Round([Math]::Min([Math]::Max(
            (138.5177312231 * [Math]::Log($ct100 - 10)) - 305.0447927307,
            0
        ), 255))
    }



$hslVal = $this.RGBToHSL($red, $green, $blue)

[PSCustomObject]@{
    PSTypeName='LightScript.Color'
    Hue=$hslVal.Hue
    Saturation=$hslVal.Saturation
    Luminance=$hslVal.Luminance
    Red=$red
    Green=$green
    Blue=$blue    
}