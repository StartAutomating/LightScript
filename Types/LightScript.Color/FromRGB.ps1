param(
[string]
$HexColor
)

$hc = $HexColor
$r,$g,$b = 
    if ($hc.Length -eq 7) {
        [int]::Parse($hc[1..2]-join'', 'HexNumber')
        [int]::Parse($hc[3..4]-join '', 'HexNumber')
        [int]::Parse($hc[5..6] -join'', 'HexNumber')
    }elseif ($hc.Length -eq 4) {
        [int]::Parse($hc[1], 'HexNumber') * 16
        [int]::Parse($hc[2], 'HexNumber') * 16
        [int]::Parse($hc[3], 'HexNumber') * 16
    }

$hslVal = $this.RGBToHSL($r, $g, $b)

[PSCustomObject]@{
    PSTypeName='LightScript.Color'
    Hue=$hslVal.Hue
    Saturation=$hslVal.Saturation
    Luminance=$hslVal.Luminance
    Red=$r
    Green=$g
    Blue=$b
}

