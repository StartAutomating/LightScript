function Watch-NanoLeaf
{
    <#
    .Synopsis
        Watches a NanoLeaf for touch events
    .Description
        Watches a NanoLeaf for touch events.


        A background job is launched to monitor for UDP messages from a given Nanoleaf.

        These messages are unpacked and translated into PowerShell events:

        * NanoLeaf.Touch.Hover
        * NanoLeaf.Touch.Hold
        * NanoLeaf.Touch.Down
        * NanoLeaf.Touch.Up
        * NanoLeaf.Touch.Swipe
    .Link
        Get-NanoLeaf
    .Example
        Watch-NanoLeaf
    #>
    [OutputType([Management.Automation.Job])]
    param(
    # The IP Address of the NanoLeaf.
    [Parameter(ValueFromPipelineByPropertyName)]
    [IPAddress]
    $IPAddress = $([IPAddress]::any),

    # The nanoleaf token
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $NanoLeafToken,

    # The UDP port used for TouchStreamData
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $TouchEventsPort = $(Get-Random -Minimum 250 -Maximum 5kb)
    )

    begin {
        #region Declare ScriptBlocks
        $watchNanoLeafTouchUDP = {
            param([IPAddress]$ipaddress, [int]$TouchPort)
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Hover -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Hold -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Down -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Up -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Swipe -Forward

            $udpSvr=  [Net.Sockets.UdpClient]::new()
            $endpoint = [Net.IpEndpoint]::new([ipaddress]::Any, $TouchPort)
            try {
                $udpSvr.Client.Bind($endpoint)
            } catch  {
                Write-Error -Message $_.Message -Exception $_
                return
            }

            while ($true) {
                $packet = $udpSvr.Receive([ref]$endpoint)
                $panelCount = [BitConverter]::ToUInt16($packet[1..0],0)
                $offset = 2
                for ($i =0 ; $i -lt $panelCount; $i++) {
                    $offset = 2 + ($I * 5)

                    $dataByte = [BitConverter]::ToString($packet[$offset + 2])

                    $eventData = [PSCustomObject]@{
                        FromPanelID = [BitConverter]::ToUInt16(@($packet[$offset + 1],$packet[$offset]), 0)
                        ToPanelID = [BitConverter]::ToUInt16(@($packet[$offset + 4],$packet[$offset + 3]), 0)

                        TouchStrength = [int]::Parse($dataByte[1], "HexNumber")
                        TouchType = [int]::Parse($dataByte[0], "HexNumber")
                        Packet = $packet
                    }

                    $touchTypes = 'Hover', 'Down', 'Hold', 'Up','Swipe'
                    $touchType = $touchTypes[$eventData.TouchType]

                    New-Event -Sender $IPAddress -EventArguments $eventData -MessageData $eventData -SourceIdentifier "NanoLeaf.Touch.$touchType" | Out-Null
                }
            }
        }

        $watchNanoLeafJob = {
            param($IPAddress,$NanoLeafToken, $touchEventPort = 199)

            $touchEventRequest =
                [Net.HttpWebRequest]::CreateHttp("http://${IPAddress}:16021/api/v1/$NanoLeafToken/events?id=4")
            $touchEventRequest.Headers.Add("TouchEventsPort",$touchEventPort)

            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Hover -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Hold -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Down -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Up -Forward
            Register-EngineEvent -SourceIdentifier NanoLeaf.Touch.Swipe -Forward

            $touchEventResponse = $touchEventRequest.GetResponse()
            $responseStream = $touchEventResponse.GetResponseStream()

            while ($true) {
                <# $buff = [byte[]]::new(2kb)
                $bytesRead = $responseStream.Read($buff,0,$buff.Length)
                if ($bytesRead -gt 0) {
                    [Text.Encoding]::UTF8.GetString($buff -ne 0)
                }
                $buff = $null
                #>
                Start-Sleep -milliseconds 100
            }
        }
        #endregion Declare ScriptBlocks
    }

    process {
        #region Handle Broadcast Recursively
        if ($IPAddress -in [IPAddress]::Any,[IPAddress]::Broadcast) {
            $splat = @{} + $PsBoundParameters
            $splat.Remove('IPAddress')
            $splat.Remove('NanoLeafToken')
            foreach ($val in $Script:NanoLeafCache.Values) {
                $splat['IPAddress'] = $val.IPAddress
                $splat['NanoLeafToken'] = $val.NanoLeafToken
                Watch-NanoLeaf @splat
            }
            return
        }
        #endregion Handle Broadcast Recursively

        Start-Job -ScriptBlock $watchNanoLeafJob -Name "Watch-NanoLeaf-$($IPAddress)" -ArgumentList $IPAddress,$NanoLeafToken, $TouchEventsPort
        Start-Job -ScriptBlock $watchNanoLeafTouchUDP -Name "Watch-NanoLeaf-$($IPAddress)" -ArgumentList $IPAddress,$TouchEventsPort
    }
}

