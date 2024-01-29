function Find-Pixoo
{
    <#
    .SYNOPSIS
        Finds Pixoo devices
    .DESCRIPTION
        Finds Pixoo devices on the local network.
    .EXAMPLE
        Find-Pixoo
    .LINK
        https://lightscript.start-automating.com/Find-Pixoo/
    .LINK
        https://app.divoom-gz.com/Device/ReturnSameLANDevice
    #>
    param()
    
    Invoke-RestMethod -Uri "https://app.divoom-gz.com/Device/ReturnSameLANDevice" | 
        Select-Object -ExpandProperty DeviceList 
}