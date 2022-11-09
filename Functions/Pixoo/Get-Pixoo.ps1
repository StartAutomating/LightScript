function Get-Pixoo
{
    <#
    .Synopsis
        Gets Pixoo Devices
    .Description
        Gets saved Pixoo Devices
    .Example
        Get-Pixoo
    .LINK
        Connect-Pixoo
    .LINK
        Set-Pixoo
    #>
    [CmdletBinding(DefaultParameterSetName="ListDevices")]
    param(
    # The IP Address for the Pixoo device.
    # This can be discovered thru the phone user interface or by using Find-Pixoo.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('PixooIPAddress')]
    [IPAddress[]]
    $IPAddress,

    # If set, will get the local weather.
    [Parameter(Mandatory,ParameterSetName='Weather')]
    [switch]
    $Weather,

    # If set, will get uploads.
    [Parameter(Mandatory,ParameterSetName='Uploads')]
    [Alias('Uploads')]
    [switch]
    $Upload,

    # If set, will clear any cached results.
    [switch]
    $Force    
    )

    begin {
        if (-not $script:PixooCache) {
            $script:PixooCache = @{}
        }

        if (-not $script:PixooDataCache -or $force) {
            $script:PixooDataCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }
    
    process {
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home) {
                # Read all .pixoo.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.pixoo.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $pixooConnection = $_                        
                        $script:PixooCache["$($pixooConnection.IPAddress)"] = $pixooConnection
                    }

                $IPAddress = $script:PixooCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices

        if ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            return $script:PixooCache.Values
        }        

        if ($PSCmdlet.ParameterSetName -eq 'Weather') {
            
            foreach ($ip in $script:PixooCache.Keys) {
                if ($script:PixooDataCache["$ip.$($PSCmdlet.ParameterSetName)"]) {
                    $script:PixooDataCache["$ip.$($PSCmdlet.ParameterSetName)"]
                } else {
                    $script:PixooDataCache["$ip.$($PSCmdlet.ParameterSetName)"] = 
                        Invoke-RestMethod -uri "http://$ip/post" -Method Post -Body (
                            @{Command="Device/GetWeatherInfo"} | ConvertTo-Json
                        ) |
                        & { process {
                            $_.pstypenames.insert(0,'Pixoo.Weather')
                            $_
                        } }
                    $script:PixooDataCache["$ip.$($PSCmdlet.ParameterSetName)"]                    
                }
                # Because the Pixoo API only works on a LAN, we don't need to ask each device for the weather.
                break
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'Uploads') {            
            foreach ($ip in $script:PixooCache.Keys) {

                $deviceId     = $script:PixooCache[$ip].DeviceID -as [int64]
                $body = @{
                    DeviceId  = $script:PixooCache[$ip].DeviceID -as [int64]
                    DeviceMac = $script:PixooCache[$ip].MACAddress.Replace('-','').ToLower()
                } | ConvertTo-Json
                $dataCacheKey = "$ip.$($PSCmdlet.ParameterSetName)"
                if (-not $script:PixooDataCache[$dataCacheKey]) {
                
                    $restResults = Invoke-RestMethod -uri "https://app.divoom-gz.com/Device/GetImgUploadList" -Method Post -Body $body
                    $script:PixooDataCache[$dataCacheKey] = $restResults.ImgList | & { process {
                        if (-not $_) {
                            Write-Warning "Did not receive results for $deviceID.  Try again in a second (Pixoo's API can be slow)."
                            return
                        }
                        $img = $_
                        $img.pstypenames.clear()
                        $img.pstypenames.add('Divoom.Upload')
                        $img.psobject.properties.Add([psnoteproperty]::new("IPAddress", $ip))
                        $img.psobject.properties.Add([psnoteproperty]::new("DeviceID", $deviceId))
                        $img
                    } }
                    $script:PixooDataCache[$dataCacheKey]
                } else {
                    $script:PixooDataCache[$dataCacheKey]
                }
                
            }
        }
    }
}
