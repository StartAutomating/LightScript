function Get-HueBridge {
    <#
    .Synopsis
        Gets Hue Bridges
    .Description
        Gets Hue Bridges registered on the system, and gets Hue bridge resources.
    .Link
        Find-HueBridge
    .Link
        Join-HueBridge
    .Example
        Get-HueBridge
    #>
    [CmdletBinding(DefaultParameterSetName='ConnectionInfo')]
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification="Parameters used as hints for Parameter Sets")]
    param(
    # If set, will get the schedules defined on the Hue bridge
    [Parameter(Mandatory=$true,ParameterSetName='Schedules',ValueFromPipelineByPropertyName=$true)]
    [Alias('Schedules', 'Timer', 'Timers')]
    [Switch]
    $Schedule,

    # If set, will get the rules defined on the Hue bridge
    [Parameter(Mandatory=$true,ParameterSetName='Rules',ValueFromPipelineByPropertyName=$true)]
    [Alias('Rules', 'Trigger', 'Triggers')]
    [Switch]
    $Rule,

    # If set, will get the scenes defined on the Hue bridge
    [Parameter(Mandatory=$true,ParameterSetName='Scenes',ValueFromPipelineByPropertyName=$true)]
    [Alias('Scenes')]
    [Switch]
    $Scene,

    # If set, will get the sensors defined on the Hue bridge
    [Parameter(Mandatory=$true,ParameterSetName='Sensors',ValueFromPipelineByPropertyName=$true)]
    [Alias('Sensors')]
    [Switch]
    $Sensor,

    # If set, will get the groups (or rooms) defined on the Hue bridge
    [Parameter(Mandatory=$true,ParameterSetName='Groups',ValueFromPipelineByPropertyName=$true)]
    [Alias('Groups','Room', 'Rooms')]
    [Switch]
    $Group,

    # If set, will get the device configuration
    [Parameter(Mandatory=$true,ParameterSetName='Config',ValueFromPipelineByPropertyName=$true)]
    [Switch]
    $Configuration,

    # If set, will get the device capabilities
    [Parameter(Mandatory=$true,ParameterSetName='Capabilities',ValueFromPipelineByPropertyName=$true)]
    [Alias('Capabilities')]
    [Switch]
    $Capability,

    # If set, will get resources defined on the device
    [Parameter(Mandatory=$true,ParameterSetName='Resourcelinks',ValueFromPipelineByPropertyName=$true)]
    [Alias('Resources', 'ResourceLink', 'ResourceLinks')]
    [Switch]
    $Resource,

    # If set, will get the lights defined on the device
    [Parameter(Mandatory=$true,ParameterSetName='Lights',ValueFromPipelineByPropertyName=$true)]
    [Alias('Lights')]
    [Switch]
    $Light,

    # If provided, will filter returned items by name
    [Parameter(Position=0,ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $Name,

    # If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    $RegularExpression,

    # If set, will treat the Name parameter as a specific match
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    $ExactMatch,

    # If provided, will filter returned items by ID
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $ID,

    # If set, will requery each returned resource to retreive additional information.
    [Switch]
    $Detailed
    )


    begin {
        if ($home) { # If there's a $home directory, construct a LightScript root.
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
        if (-not $script:cachedBridges) { # If there were not cached bridges
            $script:cachedBridges = if (Test-Path $lightScriptRoot) { # and the LightScript root exists
                Get-ChildItem -Path $lightScriptRoot -Filter *.huebridge.clixml -Force | # find any bridge files.
                    Import-Clixml -Path { $_.FullName } # and import the clixml.
            }  else {
                @()
            }

            $script:cachedBridges = foreach ($cb in @($script:cachedBridges)) {
                $pingedIt =
                    if ($PSVersionTable.Platform -ne 'Unix') {
                        @(ping -w 1000 $cb.IPAddress -n 1) -like 'reply*'
                    } else {
                        @(@(ping -w 1 $cb.IPAddress -c 1) -match $($cb.IPAddress -replace '\.','\.')).Count -gt 2
                    }
                if (-not $pingedIt) {
                    Write-Warning "Hue Bridge '$($cb.DeviceID)' not found at $($cb.IPAddress)"
                } else {
                    $cb
                }
            }

        }
        $bridges = $script:cachedBridges
    }

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ConnectionInfo') {
            $bridges
        } else {
            $bridges | # Get all bridges
                Send-HueBridge -Command $PSCmdlet.ParameterSetName.ToLower() | # get the set of data we want from the bridge.
                ForEach-Object {
                    if ('Config', 'Capabilities' -contains $psCmdlet.ParameterSetName) {
                        return $_ # config and capabilities are directly returned.
                    }
                    $list = $_ # the rest of things are returned as a list packed into a single object.

                    #region Unroll results
                    :ToTheNextItem foreach ($item in $list.psobject.properties) { # Walk over each property in the object.
                        if ($item.Name -as [int] -eq $null -and $PSCmdlet.ParameterSetName -ne 'scenes') { continue }
                        if ('IPAddress', 'HueUserName' -contains $item.Name) { continue }
                        $itemId = $item.Name
                        if ($ID -and $ID -notcontains $itemId) { continue }
                        $itemObject = @{
                            ID = $itemId
                            IPAddress = $list.IPAddress
                            HueUserName = $list.HueUserName
                            PSTypeName="Hue.$($PSCmdlet.ParameterSetName.TrimEnd('s'))"
                        }
                        $itemInfo = $item.Value
                        $allProperties = @($itemInfo.psobject.properties)
                        foreach ($prop in $allProperties) {
                            $itemObject[$prop.Name] = $prop.Value
                        }

                        if ($Name) {
                            $matched = foreach ($n in $Name) {
                                if ($RegularExpression -and $itemObject.Name -match $N) {
                                    $true
                                    break
                                } elseif ($ExactMatch -and $itemObject.Name -eq $N) {
                                    $true
                                    break
                                } elseif ($itemObject.Name -like $n) {
                                    $true
                                    break
                                }
                            }

                            if (-not $matched) { continue ToTheNextItem }
                        }

                        if ($Detailed) {
                            [PSCustomObject]$itemObject |
                                Send-HueBridge -Command ($psCmdlet.ParameterSetName.ToLower() + '/' + $itemId)
                        } else {
                            [PSCustomObject]$itemObject
                        }
                    }
                    #endregion Unroll results
                }
        }
    }
}