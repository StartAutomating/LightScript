function Add-HueLight
{
    <#
    .SYNOPSIS
        Adds lights to Hue
    .DESCRIPTION
        Adds new lights to a Hue Bridge.
    .EXAMPLE
        Add-HueLight # Search for new lights
    .EXAMPLE
        Add-HueLight -DeviceID $serialNumber # Add a new light by serial number.
    .EXAMPLE
        Add-HueLight        # Search for new lights
        Get-HueLight -New   # Get-HueLight -New will return the new lights
    .LINK
        Get-HueLight
    .LINK
        Set-HueLight
    #>
    [Rest("lights",
        Invoker="Send-HueBridge",
        Method='POST',
        ContentType='application/json',
        BodyParameter={
{
    param(
        # One or more Device Identifiers (serial numbers ).
        # Use this parameter when adding lights that have already been assigned to another bridge.
        [Alias('SerialNumber')]
        [string[]]
        $DeviceID
    )
}
        })]
    [CmdletBinding(SupportsShouldProcess)]
    param()

    begin {
        $hueBridge = Get-HueBridge
        $invokeParams = @{}
        $invokeParams.IPAddress = $hueBridge.IPAddress
        $invokeParams.HueUserName = $hueBridge.HueUserName
    }
}
