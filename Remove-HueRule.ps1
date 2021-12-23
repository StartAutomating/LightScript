function Remove-HueRule
{
    <#
    .Synopsis
        Removes Hue Rules
    .Description
        Removes Rules from one or more Hue Bridges
    .Example
        Remove-HueRule -Name 'HueRuleName'
    .Link
        Get-HueRule
    .Link
        Get-HueBridge
    .Link
        Send-HueBridge
    #>
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact="High")]
    [OutputType([PSObject])]
    param(
    #If provided, will filter returned items by name
    [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $Name,

    #If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    $RegularExpression,

    #If set, will treat the Name parameter as a specific match
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    $ExactMatch,

    #If provided, will filter returned items by ID
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $ID
    )

    process {
        $GetHueBridgeParametersDefault = ConvertFrom-Json @'
        {
            "Rules":  true
        }
'@
        $GetHueBridgeParameters = @{}
        foreach ($property in $GetHueBridgeParametersDefault.psobject.properties) {
            $GetHueBridgeParameters[$property.Name] = $property.Value
            if ($property.Value -is [string] -and $property.Value.StartsWith('$')) {
                $GetHueBridgeParameters[$property.Name] = $executionContext.SessionState.PSVariable.Get($property.Value.Substring(1)).Value
            }
        }
        #region Copy Parameters from Get-HueBridge
        $MyParameters = [Ordered]@{} + $psBoundParameters # Copy $PSBoundParameters
        foreach ($in in 'Name','ExactMatch','RegularExpression','ID','Detailed') {
            if (-not $GetHueBridgeParameters.$in -and $myParameters.$in) {
                $GetHueBridgeParameters.$in = $myParameters.$in
            }
        }
        #endregion Copy Parameters from Get-HueBridge

        Get-HueBridge @GetHueBridgeParameters |
            Where-Object {$PSCmdlet.ShouldProcess("Delete Rule$($_.Name) ($($_.ID))")}| Send-HueBridge -Method DELETE -Command {"rules/$($_.ID)"}
    }
}

