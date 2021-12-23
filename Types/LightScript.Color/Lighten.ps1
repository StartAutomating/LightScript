param(
[int]
$Amount,

[switch]
$Absolute
)
$o = 
    if ($this.Hue -or $this.Saturation -or $this.Luminance) {
        $this
    } 
    else
    {
        $this.RgbToHSL($this.Red, $this.Green, $this.Blue)
    }

if ($o.luminance -eq $null) { return }
$l = $o.luminance
if (-not $Absolute) {    
    $l +=  $l  * ($Amount / 100)
    if ($l -ge 1) { $l = 1 }
}
else {
    $l = ($Amount / 100)
    if ($l -ge 1) { $l = 1 }
}

$rgb = $this.HSLToRGB($o.Hue, $o.Saturation, $l)


[PSCustomObject]@{
    PSTypeName='LightScript.Color'
    Hue=$o.Hue
    Saturation=$o.Saturation
    Luminance=$l
    Red=$rgb.Red
    Green=$rgb.Green
    Blue=$rgb.Blue
}
