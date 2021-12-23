function Set-Twinkly
{
    <#
    .Synopsis
        Sets Twinkly Lights
    .Description
        Sets Twinkly Lights.  Changes colors, mode of operation
    .Example
        Set-Twinkly -Hue 360 -Saturation 100 -Luminance 1
    .Link
        Get-Twinkly
    .Link
        Connect-Twinkly
    #>
    [OutputType([PSObject])]
    param(
    # One or more IP Addresses of Twinkly devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('TwinklyIPAddress')]
    [IPAddress[]]
    $IPAddress,

    # Sets the hue of all lights in a fixture
    [Parameter(ValueFromPipelineByPropertyName)]
    [double]
    $Hue,

    # Sets the saturation of all lights in a fixture
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(0,1)]
    [double]
    $Saturation,

    # Sets the brightness of all lights in a fixture
    # When passed with -Hue and -Saturation, sets the color
    # When passed with no other parameters, adjusts the absolute brightness
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Luminance')]
    [ValidateRange(0,1)]
    [double]
    $Brightness,

    # Sets the red part of a color
    [Parameter(ValueFromPipelineByPropertyName)]
    [byte]
    $Red,

    # Sets the green part of a color
    [Parameter(ValueFromPipelineByPropertyName)]
    [byte]
    $Green,

    # Sets the blue part of a color
    [Parameter(ValueFromPipelineByPropertyName)]
    [byte]
    $Blue,

    # Sets lights to an RGB color.
    # If one color is provided, this will set the Twinkly color mode
    # If more than one RGB Color is provided, this will create a movie where each light alternates between each color
    # If -MovieFrameRate and
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $RGBColor,

    <#

    Will change the mode. Can be:

    * Off
    * Color
    * Demo
    * Effect
    * Movie
    * Playlist
    * RT

    Many operations require the mode to be set before they take effect.

    For instance, if you use -RGBColor, you will not see the changes if the mode is not set to 'color'.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('off','color', 'demo','effect','movie','playlist','rt')]
    [string]
    $Mode,

    # If provided, will set the device name.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $DeviceName,

    # If provided, will restart the playlist
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $RestartPlaylist,

    # The name of a movie.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $MovieName,

    # The movie framerate
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('MovieFPS')]
    [int]
    $MovieFramerate,

    # The movie LED
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('MovieLEDsPerFrame')]
    [int]
    $MovieLEDCount,

    # The number of frames in the movie.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $MovieFrameCount,

    # A byte array of movie data.
    # Each sequence of 3-4 bytes represents a light color
    # Each sequence of colors represents a frame
    # Each sequence of frames represents a movie.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('MovieFrame','MovieFrames')]
    [byte[]]
    $MovieData,

    # The size of each block within a movie.  By default, 3.
    [Parameter(ValueFromPipelineByPropertyName)]
    [byte]
    $MovieBlockSize = 3
    )
    begin {
        if (-not $script:TwinklyCache) {
            $script:TwinklyCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        if (-not $IPAddress) {
            if ($home) {
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.twinkly.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $twinklyConnection = $_
                        if ([DateTime]::Now -ge $twinklyConnection.Authentication_ExpiresAt) {
                            $twinklyConnection = Connect-Twinkly -IPAddress $twinklyConnection.IPAddress -PassThru
                        }
                        $script:TwinklyCache["$($twinklyConnection.IPAddress)"] = $twinklyConnection
                    }

                $IPAddress = $script:TwinklyCache.Keys
            }
            if (-not $IPAddress) {
                Write-Warning "No -IPAddress provided and no cached devices found"
                return
            }
        }


        $myParams = [Ordered]@{} + $PSBoundParameters

        foreach ($ip in $IPAddress) {
            $Splat = @{
                Headers= @{"X-Auth-Token" =$script:TwinklyCache["$ip"].Authentication_Token}
                Method = 'POST'
            }
            #region Set Light Color
            if ($myParams.Contains('Red') -and $myParams.Contains('Blue') -and $myParams.Contains('Green'))
            {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/led/color" @Splat -Body (
                    @{
                        red        = $red
                        blue       = $blue
                        green      = $green
                    } | ConvertTo-Json
                )
            }
            elseif ($myParams.Contains('RGBColor') -and $RGBColor.Count -eq 1)
            {
                $fromRgb = ([PSCustomObject]@{PSTypeName='LightScript.Color'}).FromRGB($RGBColor)
                Invoke-RestMethod -Uri "http://$ip/xled/v1/led/color" @Splat -Body (
                    @{
                        red        = $fromRgb.red
                        blue       = $fromRgb.blue
                        green      = $fromRgb.green
                    } | ConvertTo-Json
                )
            }
            elseif ($myParams.Contains('Hue') -and $myParams.Contains('Saturation') -and $myParams.Contains('Brightness'))
            {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/led/color" @Splat -Body (
                    @{
                        hue        = $hue % 360
                        saturation = [byte][Math]::Ceiling([Byte]::MaxValue * $Saturation)
                        value      = [byte][Math]::Ceiling([Byte]::MaxValue * $Brightness)
                    } | ConvertTo-Json
                )
            }
            #endregion Set Light Color
            elseif ($myParams.Contains("Brightness"))
            {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/led/out/brightness" @Splat -Body (
                    @{
                        mode = 'enabled'
                        type = 'A'
                        value = [int]($Brightness * 100)
                    } | ConvertTo-Json
                )
            }

            if ($FrameDelay) {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/led/movie/config" @Splat -Body (
                    @{
                        frame_delay = $FrameDelay
                    } | ConvertTo-Json
                )
            }

            #region Set Movie
            if ($RGBColor.Count -gt 1 -and -not $MovieData) {
                $MovieData =
                    foreach ($hexCol in $RGBColor) {
                        $Rgb = ([PSCustomObject]@{PSTypeName='LightScript.Color'}).FromRGB($hexCol)
                        $Rgb.Red
                        $Rgb.Green
                        $Rgb.Blue
                    }
            }

            if ($MovieData) {
                if (-not $myParams.Contains("MovieLEDCount")) {
                    $MovieLEDCount = Get-Twinkly -IPAddress $ip -Configuration |
                        Select-Object -ExpandProperty Strings |
                        Select-Object -ExpandProperty Length |
                        Measure-Object -Sum |
                        Select-Object -ExpandProperty Sum
                }
                if (-not $myParams.Contains("MovieFrameCount")) {
                    $MovieFrameCount =
                        if ($MovieData.Length -lt $MovieLEDCount) {
                            1
                        } else {
                            [Math]::Floor($MovieData.Length / $MovieLEDCount)
                        }
                }
                if (-not $myParams.Contains("MovieFrameRate")) {
                    $MovieFramerate = 1
                }

                if ($MovieData.Length -lt $MovieLEDCount) {
                    # Movie too short, assume it is a sequence of colors
                    $newMovieData = @(
                        foreach ($movieFrameNumber in 0..($MovieFrameCount - 1)) {
                            for ($b = 0; $b -lt $MovieLEDCount; $b++) {
                                $ptr = ($b  + $movieFrameNumber)* $MovieBlockSize
                                if ($ptr -ge $MovieData.Length) {
                                    $ptr = $ptr % $MovieData.Length
                                }
                                foreach ($n in 0..($MovieBlockSize- 1)) {
                                    $MovieData[$ptr  + $n]
                                }
                            }
                        }) -as [byte[]]
                    $MovieData = $newMovieData
                }

                if (-not $myParams.Contains("MovieName")) {
                    $MovieName = "Movie " + [DateTime]::Now.ToString() -replace '[:/]', '-'
                }

                Invoke-RestMethod -Uri "http://$ip/xled/v1/movies/new" @Splat -Body (
                    @{
                        name = $MovieName
                        unique_id = ([GUID]::NewGuid()).ToString().ToUpper()
                        leds_per_frame = $MovieLEDCount
                        frames_number = $MovieFrameCount
                        fps = $MovieFramerate
                    } | ConvertTo-Json
                )

                Invoke-RestMethod -Uri "$twinklyUrl/xled/v1/movies/full" @Splat -Body $MovieData -ContentType application/octect-stream
            }
            #endregion Set Movie

            #region Reset Playlist
            if ($RestartPlaylist) {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/playlist/current" @Splat -Body (
                    @{
                        id = 0
                    } | ConvertTo-Json
                )
            }
            #endregion Reset Playlist

            #region Set Mode
            if ($Off) {
                $Mode = 'off'
            }

            if ($Mode) {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/led/mode" @Splat -Body (
                    @{
                        mode = $Mode.ToLower()
                    } | ConvertTo-Json
                )
            }
            #endregion Set Mode
        }
    }
}

