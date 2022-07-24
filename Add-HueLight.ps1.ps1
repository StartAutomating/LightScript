function Add-HueLight
{
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
