function Find-HueBridge
{
    <#
    .Synopsis
        Finds Hue Bridges
    .Description
        Finds Hue Bridges on the local area network, using https://discovery.meethue.com/.
    .Example
        Find-HueBridge
    .Link
        Connect-HueBridge
    #>
    [OutputType([PSObject])]
    param()
    #region Discover Hue Bridges
    $findLocalBridge = Invoke-RestMethod -Uri "https://discovery.meethue.com/"
    foreach ($bridgeInfo in $findLocalBridge) {
        [PSCustomObject]@{
            DeviceID = $bridgeInfo.ID
            IPAddress = [IPAddress]$bridgeInfo.InternalIPAddress
            Flb = $bridgeInfo
        }
    }
    #endregion Discover Hue Bridges
}
