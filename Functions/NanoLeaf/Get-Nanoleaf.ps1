function Get-NanoLeaf
{
    <#
    .Synopsis
        Gets Nanoleaf controllers.
    .Description
        Gets connected Nanoleaf controllers on the local area network.

        Can also get effects
    .Example
        Get-NanoLeaf
    .Link
        Connect-NanoLeaf
    .Link
        Set-NanoLeaf
    #>
    [CmdletBinding(DefaultParameterSetName='All')]
    [OutputType([PSObject])]
    param(
    # The IP Address of the NanoLeaf controller.
    [Parameter(Mandatory,ParameterSetName='One',ValueFromPipelineByPropertyName)]
    [Alias('NanoLeafIP','NanoLeafIPAddress')]
    [IPAddress]
    $IPAddress,

    # The nanoleaf authorization token.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $NanoLeafToken,

    # If set, will get information about NanoLeaf panels.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Panel,

    # If set, will get information about NanoLeaf layout.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Layout,

    # If provided, will get information about a particular NanoLeaf effect
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('animName')]
    [string]
    $EffectName,

    # If provided, will get information about the plugins available to use in Nanoleaf effects.
    [Alias('Plugin','Plugins')]
    [switch]
    $ListPlugin,

    # If provided, will filter out plugins of a particular type.
    # Valid for plugins and effects.
    [ValidateSet('Rhythm', 'Color')]
    [string]
    $PluginType,

    # If set, will return a string list of effect names.
    [switch]
    $ListEffectName,

    # If set, will return a string list of effect names.
    [Alias('Effect','Effects')]
    [switch]
    $ListEffect,

    # If set, will display information about the current effect.
    [switch]
    $CurrentEffect,

    # If set, will refresh connections to all nanoleafs
    [switch]
    $Force
    )

    begin {
        if (-not $script:NanoLeafCache) {
            $script:NanoLeafCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }


    process {
        $parameterSet = $PSCmdlet.ParameterSetName
        if ($IPAddress -and $IPAddress -in [IPAddress]::Any, [IPAddress]::Broadcast) {
            $parameterSet = 'All'
        }
        if ($ParameterSet -eq 'All') {
            #region Get Cached Nanoleaves
            $myParams = @{} + $PsBoundParameters
            if (-not $Force -and $script:NanoLeafCache.Count) {
                $myParams.Remove('IPAddress')
                $myParams.Remove('NanoLeafToken')
                if ($myParams.Count) {
                    $script:NanoLeafCache.Values |
                        Get-NanoLeaf @myParams
                    return
                } else {
                    return $script:NanoLeafCache.Values
                }
            }
            #endregion Get Cached Nanoleaves
            #region Reload Nanoleaf Cache
            if ($lightScriptRoot) {
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.nanoleaf.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        $cachedNanoLeaf = $_
                        if (-not $cachedNanoLeaf) { return }
                        if (-not $cachedNanoLeaf.IPAddress) { return }
                        $pingedIt =
                            if ($PSVersionTable.Platform -ne 'Unix') {
                                @(ping -w 2000 $cachedNanoLeaf.IPAddress -n 2) -like 'reply*'
                            } else {
                                @(@(ping -w 2 $cachedNanoLeaf.IPAddress -c 2) -match $($cachedNanoLeaf.IPAddress -replace '\.','\.')).Count -gt 2
                            }
                        if (-not $pingedIt) {
                            Write-Warning "NanoLeaf '$($cachedNanoLeaf.DeviceName)' not found at $($cachedNanoLeaf.IPAddress)"
                        } else {
                            $cachedNanoLeaf
                        }
                    } |
                    Get-NanoLeaf -Force -Panel:$Panel -Layout:$Layout
            }
            #endregion Reload Nanoleaf Cache

        }
        elseif ($ParameterSet -eq 'One') {
            # If we're getting information about a single nanoleaf
            if (-not $PsBoundParameters['NanoLeafToken'] -and $Script:NanoLeafCache[$IPAddress].NanoLeafToken)
            {
                # Check the cache for the auth token (if not passed).
                $PsBoundParameters['NanoLeafToken'] = $NanoLeafToken = $Script:NanoLeafCache[$IPAddress].NanoLeafToken
            }

            $ipAndToken = @{IPAddress=$psBoundParameters['IPAddress'];NanoLeafToken=$psBoundParameters['NanoLeafToken']}
            if ($Force) { $script:NanoLeafCache.Remove($IPAddress) } # If -Force was passed, invalidate the cache.

            if (-not $script:NanoLeafCache[$IPAddress]) { # If the cache is empty

                $script:NanoLeafCache[$IPAddress] = # Get the root information about the nanoleaf
                    Invoke-RestMethod -Uri "http://${IPAddress}:16021/api/v1/$NanoLeafToken" |
                        ForEach-Object {
                            $_.pstypenames.clear() # decorate it as a 'Nanoleaf'
                            $_.pstypenames.add('Nanoleaf')
                            $_
                        } |
                        Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                        Add-Member NoteProperty NanoLeafToken $NanoLeafToken -Force -PassThru
            }


            if ($Panel -or $Layout) {
                foreach ($posData in $script:NanoLeafCache[$IPAddress].panelLayout.layout.positionData) {  # If we asked for panels or positional data
                    $posData.pstypenames.clear() # decorate it as a 'Nanoleaf.Panel'
                    $posData.pstypenames.add('NanoLeaf.Panel')
                    $posData |
                        Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                        Add-Member NoteProperty ControllerName $script:NanoLeafCache[$IPAddress].name -Force -PassThru:$Panel
                }

                if ($layout) { # If -Layout was passed,
                    $script:NanoLeafCache[$IPAddress].panelLayout.layout.pstypenames.clear() # decorate that information as 'NanoLeaf.Layout'
                    $script:NanoLeafCache[$IPAddress].panelLayout.layout.pstypenames.add('NanoLeaf.Layout')
                    $script:NanoLeafCache[$IPAddress].panelLayout.layout # and return it.
                }
            }
            elseif ($CurrentEffect)
            {
                # If we're asking about the current effect
                $nanoLeafInfo = Get-NanoLeaf @ipAndToken -Force # get this nanoleaf
                $nanoLeafInfo |
                    Get-NanoLeaf -EffectName { # and get information about the selected effect.
                        $_.effects.select
                    }
            } elseif ($EffectName)
            {
                # If we want information about an effect by name
                Send-NanoLeaf @ipAndToken -Command "effects" -Data (@{
                    write = @{command = 'request';animName=$EffectName} # we write a request command (to read the data).
                }) -Method PUT -PSTypeName 'NanoLeaf.Effect'
            }
            elseif ($ListEffectName)
            {
                # If we want to list the effects, call the appropriate command.
                Send-NanoLeaf @ipAndToken -Command "effects/effectsList"
            }
            elseif ($ListPlugin)
            {
                # If we're listing plugins
                Send-NanoLeaf @ipAndToken -Command "effects" -Data (@{
                    write = @{command = 'requestPlugins'} # we write to the requestPlugins command (to read the data).
                }) -Method PUT -ExpandProperty plugins -PSTypeName 'NanoLeaf.Effect.Plugin' |
                    Where-Object {
                        $in = $_
                        # Don't forge to filter -PluginType (if provided)
                        if ($PluginType -and $in.Type -eq $PluginType) {
                            $true
                        }
                        elseif (-not $PluginType) { $true}
                    } |
                    Sort-Object type, name # and sort them by type and then name
            }
            elseif ($ListEffect)
            {
                # If we're listing effects
                Send-NanoLeaf @ipAndToken -Command "effects" -Data (@{
                    write = @{command = 'requestAll'} # we write to the requestAll command (to read the data).
                }) -Method PUT -ExpandProperty animations -PSTypeName 'NanoLeaf.Effect' |
                    Where-Object {
                        $in = $_
                        # Don't forge to filter -PluginType (if provided).
                        if ($PluginType -and $in.PluginType -eq $PluginType) {
                            $true
                        }
                        elseif (-not $PluginType) { $true}
                    } |
                    Sort-Object PluginType, animName | # and sort them by pluginType and animName
                    Select-Object -Unique
            }
            else
            {
                # If we're just returning nanoleaves, just output the cache
                $script:NanoLeafCache[$IPAddress]
            }
        }
    }
}