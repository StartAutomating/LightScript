function Send-NanoLeaf
{
    <#
    .Synopsis
        Sends messages to a NanoLeaf
    .Description
        Sends HTTP messages to a NanoLeaf
    .Link
        Get-NanoLeaf
    .Example
        Send-NanoLeaf -Command effects/effectsList
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Low')]
    [OutputType([PSObject])]
    param(
    # The IP Address of the NanoLeaf.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [IPAddress]
    $IPAddress,

    # The URI fragment to send to the nanoleaf.
    [string]
    $Command,

    # The HTTP method to send.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Method = 'GET',

    # The data to send.  This will be converted into JSON if it is not a string.
    [Parameter(ValueFromPipelineByPropertyName)]
    [PSObject]
    $Data,

    # A set of additional properties to add to an object
    [Parameter(ValueFromPipelineByPropertyName)]
    [Collections.IDictionary]
    $Property = @{},

    # A list of property names to remove from an object
    [string[]]
    $RemoveProperty,

    # If provided, will expand a given property returned from the REST api.
    [string]
    $ExpandProperty,

    # The typename of the results.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $PSTypeName,

    # The nanoleaf token
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $NanoLeafToken
    )

    process {
        #region Handle Broadcasting Recursively
        if ($IPAddress -in [IPAddress]::Any,[IPAddress]::Broadcast) {
            $splat = @{} + $PsBoundParameters
            $splat.Remove('IPAddress')
            $splat.Remove('NanoLeafToken')
            foreach ($val in $Script:NanoLeafCache.Values) {
                $splat['IPAddress'] = $val.IPAddress
                $splat['NanoLeafToken'] = $val.NanoLeafToken
                Send-NanoLeaf @splat
            }
            return
        }
        #endregion Handle Broadcasting Recursively


        if (-not $PsBoundParameters['NanoLeafToken'] -and $Script:NanoLeafCache[$IPAddress].NanoLeafToken)
        {
            $PsBoundParameters['NanoLeafToken'] = $NanoLeafToken = $Script:NanoLeafCache[$IPAddress].NanoLeafToken
        }

        if (-not $NanoLeafToken) { Write-Error "No -NanoLeafToken"; return }

        $splat = @{
            uri = "http://${IPAddress}:16021/api/v1/$NanoLeafToken/$Command"
            method = $Method
        }

        if ($Data) {
            if ($data -is [string]){
                $splat.body = $data
            } else {
                $splat.body = ConvertTo-Json -Compress -Depth 10 -InputObject $Data
            }
        }

        if ($WhatIfPreference) {
            return $splat
        }

        if (-not $property) { $property = [Ordered]@{}  }
        $property['NanoLeafToken'] = $NanoLeafToken
        $property['IPAddress'] = $IPAddress

        $psProperties = @(
            foreach ($propKeyValue in $Property.GetEnumerator()) {
                if ($propKeyValue.Value -as [ScriptBlock[]]) {
                    [PSScriptProperty]::new.Invoke(@($propKeyValue.Key) + $propKeyValue.Value)
                } else {
                    [PSNoteProperty]::new($propKeyValue.Key, $propKeyValue.Value)
                }
            }
        )
        if (-not $PSCmdlet.ShouldProcess("$($splat.Method) $($splat.URI)")) { return }
        Invoke-RestMethod @splat 2>&1 |
             & { process {
                $in = $_
                if (-not $in -or $in -eq 'null') { return }
                if ($ExpandProperty) {
                    if ($in.$ExpandProperty) {
                        $in.$ExpandProperty
                    }
                } else {
                    $in # pass it down the pipe.
                }
            } } 2>&1 |
            & { process { # One more step of the pipeline will unroll each of the values.

                if ($_ -is [string]) { return $_ }
                if ($null -ne $_.Count -and $_.Count -eq 0) { return }
                $in = $_
                if ($PSTypeName -and # If we have a PSTypeName (to apply formatting)
                    $in -isnot [Management.Automation.ErrorRecord] # and it is not an error (which we do not want to format)
                ) {
                    $in.PSTypeNames.Clear() # then clear the existing typenames and decorate the object.
                    foreach ($t in $PSTypeName) {
                        $in.PSTypeNames.add($T)
                    }
                }

                if ($Property -and $Property.Count) {
                    foreach ($prop in $psProperties) {
                        $in.PSObject.Members.Add($prop, $true)
                    }
                }
                if ($RemoveProperty) {
                    foreach ($propToRemove in $RemoveProperty) {
                        $in.PSObject.Properties.Remove($propToRemove)
                    }
                }
                if ($DecorateProperty) {
                    foreach ($kv in $DecorateProperty.GetEnumerator()) {
                        if ($in.$($kv.Key)) {
                            foreach ($v in $in.$($kv.Key)) {
                                if ($null -eq $v -or -not $v.pstypenames) { continue }
                                $v.pstypenames.clear()
                                foreach ($tn in $kv.Value) {
                                    $v.pstypenames.add($tn)
                                }
                            }
                        }
                    }
                }
                return $in # output the object and we're done.
            } }
        foreach ($ir in $invokeResult) {
            $ir.psobject.properties.add($nanoLeafTokenProperty)
            $ir.psobject.properties.add($ipNoteProperty)
            $ir
        }
    }
}
