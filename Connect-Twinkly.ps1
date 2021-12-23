function Connect-Twinkly
{
    <#
    .Synopsis
        Connects to a Twinkly light controller.
    .Description
        Connects to a Twinkly light controller
    .Example
        Connect-Twinkly 192.168.0.144 -PassThru
    .Link
        Get-Twinkly

    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('TwinklyIPAddress')]
    [IPAddress]
    $IPAddress,

    # If set, will output the connection information.
    [switch]
    $PassThru
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        #region Create a Login
        $twinklyLogin = Invoke-RestMethod -Uri "http://$IPAddress/xled/v1/login" -Method POST -Body (
            @{
                challenge=[Convert]::ToBase64String(@(foreach ($n in 1..32) {50..115 | Get-Random }))
            } | ConvertTo-Json
        )
        #endregion Create a Login


        if ($twinklyLogin) {
            #region Validate the Login
            $null = Invoke-RestMethod -Uri "http://$IPAddress/xled/v1/verify" -Headers @{
                "X-Auth-Token" = $twinklyLogin.authentication_token
            } -Method Post
            #endregion Validate the Login

            #region Get Device Information
            $twinklyDeviceInfo = Invoke-RestMethod -Uri "http://$IPAddress/xled/v1/gestalt"
            $twinklyDeviceInfo = $twinklyDeviceInfo |
                    Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                    Add-Member NoteProperty Authentication_Token $twinklyLogin.authentication_token -Force -PassThru |
                    Add-Member NoteProperty Authentication_ExpiresAt ([DateTime]::Now.AddSeconds($twinklyLogin.authentication_token_expires_in)) -Force -PassThru
            #endregion Get Device Information

            #region Save Device Information
            if ($home -and $twinklyDeviceInfo) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }


                $twinklyDataFile = Join-Path $lightScriptRoot ".$($twinklyDeviceInfo.uuid).twinkly.clixml"

                $twinklyDeviceInfo |
                    Export-Clixml -Path $twinklyDataFile
            }
            #endregion Save Device Information
            if ($PassThru) {
                $twinklyDeviceInfo
            }
        }
    }
}
