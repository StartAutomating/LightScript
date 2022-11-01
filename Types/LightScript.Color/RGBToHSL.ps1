param(
# The red part
[Parameter(Mandatory=$true,Position=0)]
[Alias('R')]
[Byte]
$Red,

# The green part
[Parameter(Mandatory=$true,Position=1)]
[Alias('G')]
[Byte]
$Green,

# The blue part
[Parameter(Mandatory=$true,Position=2)]
[Alias('B')]
[Byte]
$Blue
)

[float]$PercentRed = $Red / 255
[float]$PercentGreen = $Green / 255
[float]$PercentBlue = $Blue / 255

$min = $max = $PercentRed
foreach ($_ in $PercentGreen, $PercentBlue) {
    if ($_ -lt $min) { $min = $_ }
    if ($_ -ge $max) { $max = $_ }
}

$Luminance = ($min + $max)  / 2
$delta = $max - $min
    
if (-not $delta) {
    $hue = $saturation = 0                 
} else {
    $saturation = $delta
    $saturation /= (1 - [Math]::Abs(((2 * $Luminance) -1)))
      
    $hue =  
        if ($Max -eq $PercentRed){
            ($PercentGreen - $PercentBlue)/$delta % 6      
        } elseif ($max -eq $PercentGreen) {
            (($PercentBlue - $PercentRed)/ $delta) + 2
        } else {                
            (($PercentRed - $PercentGreen)/ $delta) + 4
        }
}
$hue*=60
if ($hue -gt 360) { $hue -= 360 } 
if ($hue -lt 0) { $hue = 360 + $hue } 
[PSCustomObject][Ordered]@{
    PSTypeName = 'LightScript.Color'
    Hue = $hue
    Saturation = $saturation
    Luminance = $Luminance
}
