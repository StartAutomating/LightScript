function Get-LaMetricTime {
    <#
    .Synopsis
        Gets LaMetricTime
    .Description
        Gets LaMetricTime devices.
    .Example
        Get-LaMetricTime
    .Link
        Connect-LaMetricTime
    #>
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='ListDevices')]
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification="Parameters used as hints for Parameter Sets")]
    param(
    # One or more IP Addresses of LaMetricTime devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LaMetricTimeIPAddress')]
    [IPAddress[]]
    $IPAddress
    )
    begin {
        if (-not $script:LaMetricTimeCache) {
            $script:LaMetricTimeCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }
    process {
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home) {
                # Read all .LaMetricTime.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.LaMetricTime.clixml -Force |
                    Import-Clixml |                     
                    ForEach-Object {
                        if (-not $_) { return }
                        $laMetricTimeDevice = $_                        
                        $script:LaMetricTimeCache["$($laMetricTimeDevice.IPAddress)"] = $laMetricTimeDevice
                    }
                    
                $IPAddress = $script:LaMetricTimeCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress
                Write-Warning "No -IPAddress provided and no cached devices found" # warn
                return # and return.
            }
        }
        #endregion Default to All Devices
        if ($PSCmdlet.ParameterSetName -like '/*') {
            foreach ($ip in $IPAddress) {
                $ipAndPort = "${ipAddress}:8080"
                $endpoint  = $PSCmdlet.ParameterSetName -replace '^/api'
                #region Connect to the Device
                
                Invoke-RestMethod ('http://',$ipAndPort,'/api/',$endpoint,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } |
                    & { process {
                        $out = $_
                        $out.pstypenames.clear()
                        $out.pstypenames.add("LaMetric.Time.$endpoint")
                        $out
                    } }
            }
        } 
        elseif ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            $script:LaMetricTimeCache.Values
        }
    }
}


