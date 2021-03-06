Get-HueBridge |
    Send-HueBridge -Command ' '

# Slow blink
Get-HueBridge |
    Send-HueBridge -Command lights/4/state -Data (New-Object PSObject -Property @{alert='lselect'}) -Method put


# Stop blink
Get-HueBridge |
    Send-HueBridge -Command lights/4/state -Data (New-Object PSObject -Property @{alert='none'}) -Method put

$warmHue = 6291
$randomHue = Get-Random -Maximum 64kb
Get-HueBridge |
    Send-HueBridge -Command lights/4/state -Data (New-Object PSObject -Property @{transitiontime='1';hue=$randomHue}) -Method put

$randomHue = Get-Random -Maximum 64kb
Get-HueBridge |
    Send-HueBridge -Command lights/4/state -Data (New-Object PSObject -Property @{transitiontime=15000;hue=$randomHue}) -Method put

Get-HueBridge |
    Send-HueBridge -Command lights/4/state -Data (New-Object PSObject -Property @{transitiontime=15000;hue=$warmHue}) -Method put

