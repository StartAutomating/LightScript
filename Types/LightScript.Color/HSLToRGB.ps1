param(
# The hue
[Parameter(Mandatory=$true,Position=0)]
[Alias('H')]
[ValidateRange(0,360)]
[float]
$Hue,

# The saturation
[Parameter(Mandatory=$true,Position=1)]
[Alias('S')]
[ValidateRange(0,1)]
[float]
$Saturation,

# The luminance
[Parameter(Mandatory=$true,Position=2)]
[Alias('L')]
[ValidateRange(0,1)]
[float]
$Luminance
)

$hueRgb = {
    param($p,$q,$t)
    if ($t -lt 0) { $t += 1 }
    if ($t -gt 1) { $t -= 1 }
    if ($t -lt 1/6) {  return $P + ($q -$p) * 6 * $t }
    if ($t -lt 1/2) {  return $q }
    if ($t -lt 2/3) {  return $P + ($q -$p) * 6 * (2/3 * $t) }
    return $p
}


$C = (1 - [Math]::Abs((2 * $Luminance) - 1)) * $Saturation
$hh = $hue / 60
$X = $c * (1 - [Math]::Abs($hh % 2 -1))
$m  = $Luminance - $c /2 
$red = $green = $blue = 0 

if ($hh -ge 0 -and $hh -lt 1) {
    $red = $C
    $green = $X
} 
elseif ($hh -ge 1 -and $hh -lt 2) {
    $red = $x
    $green = $c
} 
elseif ($hh -ge 2 -and $hh -lt 3) {
    $green = $c
    $blue = $x 
} 
elseif ($hh -ge 3 -and $hh -lt 4) {
    $green = $x 
    $blue = $c 
} 
elseif ($hh -ge 4 -and $hh -lt 5) {
    $red = $x
    $blue = $c
} else {
    $red = $c
    $blue = $x
}

$red += $m
$blue += $m
$green += $m
 

[PSCustomObject][Ordered]@{
    Red = [Byte][Math]::Round($red * 255)
    Green = [Byte][Math]::Round($green * 255)
    Blue = [Byte][Math]::Round($blue * 255)
}

    
