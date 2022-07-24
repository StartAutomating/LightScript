function Send-HueBridge
{
    <#
    .Synopsis
        Sends messages to a HueBridge
    .Description
        Sends messages to a Hue Bridge
    .Example
        Get-HueBridge | Send-HueBridge -Command lights
    .Link
        Get-HueBridge
    #>
    [OutputType([PSObject])]
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Low')]
    param(
    # The IP address of the hue bridge.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [IPAddress]
    $IPAddress,

    # The hue user name
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('UserName','AuthToken')]
    [string]
    $HueUserName,

    # The command being sent to the bridge.  This is a partial URI.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Uri','Url')]
    [string]
    $Command,

    # The data being sent to the Hue Bridge.
    # If this data is not a string, it will be converted to JSON.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Data')]
    [PSObject]
    $Body,

    # The HTTP method.  By default, Get.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Method = 'GET',

    # If set, will output the data that would be sent to the bridge.
    # This is useful for creating scheudles, routines, and other macros.
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('OutputParameter','OutputParameters','OutputArgument', 'OutputArguments')]
    [switch]
    $OutputInput,

    # If provided, will set the .pstypenames on output objects.
    # This enables the PowerShell types and formatting systems.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Decorate')]
    [string[]]
    $PSTypeName
    )

    process {
        if (-not $Command -and
            $MyInvocation.InvocationName -ne $MyInvocation.MyCommand.Name) {
            $Command = $MyInvocation.InvocationName -replace '^Hue'
        }

        #region Construct the Message Body
        $splat = @{
            uri = "http://$IPAddress/api/$HueUserName/$Command"
            method = $Method
        }

        if ($Body) {
            if ($Body -is [string]){
                $splat.body = $Body
            } else {
                $splat.body = ConvertTo-Json -Compress -Depth 100 -InputObject $Body
            }
        }
        #endregion Construct the Message Body

        if ($OutputInput -or $WhatIfPreference) { # If -OutputInput or -WhatIf was passed
            if ($Body) { $splat.body = $Body }
            $splat.address = ([uri]$splat.uri).LocalPath # Make an address property with a relative URI
            $splat.Remove('uri') # and remove URI
            $splat
            return # then return.
        }

        #region Invoke-RestMethod and decorate resultsa
        Write-Verbose "Sending command to $($splat.Uri)"
        $invokeResult = Invoke-RestMethod @splat 2>&1
        # Always add a HueUserName and IPAddress to each result
        $userNameNoteProperty = [PSNoteProperty]::new('HueUserName', $HueUserName)
        $ipNoteProperty = [PSNoteProperty]::new('IPAddress', $IPAddress)
        foreach ($ir in $invokeResult) {
            $ir.psobject.properties.add($userNameNoteProperty)
            $ir.psobject.properties.add($ipNoteProperty)
            if ($PSTypeName) {
                $ir.pstypenames.clear()
                foreach ($tn in $PSTypeName) { $ir.pstypenames.add($tn) }
            } else {
                $ir.pstypenames.clear()
                $ir.pstypenames.add("Hue.$Command")
            }
            $ir
        }
        #endregion Invoke-RestMethod and decorate resultsa
    }
}
