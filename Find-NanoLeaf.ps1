function Find-NanoLeaf
{
    <#
    .Synopsis
        Finds NanoLeaf controllers
    .Description
        Finds NanoLeaf controllers on your local area network, using SSDP.
    .Link
        Connect-NanoLeaf
    .Example
        Find-NanoLeaf | Connect-NanoLeaf
    #>
    [OutputType('Roku.BasicInfo')]
    [CmdletBinding()]
    param(
    # The search timeout, in seconds.  Increase this number on slower networks.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]$SearchTimeout = 5,

    # If set, will force a rescan of the network.
    # Otherwise, the most recent cached result will be returned.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force,

    # The type of the device to find.  By default, ssdp:all.
    # Changing this value is unlikely to find any NanoLeaf controllers, but you can see other devices with -Verbose.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]$DeviceType = 'ssdp:all'
    )

    begin {
        #region Embedded C# SSDP Finder
        if (-not ('StartAutomating.NanoLeafFinder' -as [type])) {
Add-Type -TypeDefinition @'
namespace StartAutomating
{
    using System;
    using System.Net;
    using System.Net.Sockets;
    using System.Text;
    using System.Timers;
    using System.Collections.Generic;

    public class NanoLeafFinder
    {
        public List<string> FindDevices(string deviceType = "ssdp:all", int searchTimeOut = 5)
        {
            List<string> results = new List<string>();
            const int MaxResultSize = 8096;
            const string MulticastIP = "239.255.255.250";
            const int multicastPort = 1900;

            byte[] multiCastData = Encoding.UTF8.GetBytes(string.Format(@"M-SEARCH * HTTP/1.1
HOST: {0}:{1}
MAN: ""ssdp:discover""
MX: {2}
ST: {3}
", MulticastIP, multicastPort, searchTimeOut, deviceType));

            Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
            socket.SendBufferSize = multiCastData.Length;
            SocketAsyncEventArgs sendEvent = new SocketAsyncEventArgs();
            sendEvent.RemoteEndPoint = new IPEndPoint(IPAddress.Parse(MulticastIP), multicastPort);
            sendEvent.SetBuffer(multiCastData, 0, multiCastData.Length);
            sendEvent.Completed += (sender, e) => {
                if (e.SocketError != SocketError.Success) { return; }

                switch (e.LastOperation)
                {
                    case SocketAsyncOperation.SendTo:
                        // When the initial multicast is done, get ready to receive responses
                        e.RemoteEndPoint = new IPEndPoint(IPAddress.Any, 0);
                        byte[] receiveBuffer = new byte[MaxResultSize];
                        socket.ReceiveBufferSize = receiveBuffer.Length;
                        e.SetBuffer(receiveBuffer, 0, MaxResultSize);
                        socket.ReceiveFromAsync(e);
                        break;

                    case SocketAsyncOperation.ReceiveFrom:
                        // Got a response, so decode it
                        string result = Encoding.UTF8.GetString(e.Buffer, 0, e.BytesTransferred);
                        if (result.StartsWith("HTTP/1.1 200 OK", StringComparison.InvariantCultureIgnoreCase)) {
                            if (! results.Contains(result)) { results.Add(result); }
                        }

                        if (socket != null)// and kick off another read
                            socket.ReceiveFromAsync(e);
                        break;
                    default:
                        break;
                }
            };

            Timer t = new Timer(TimeSpan.FromSeconds(searchTimeOut + 1).TotalMilliseconds);
            t.Elapsed += (e, s) => { try { socket.Dispose(); socket = null; } catch {}};

            // Kick off the initial Send
            socket.SetSocketOption(SocketOptionLevel.IP,SocketOptionName.MulticastInterface, IPAddress.Parse(MulticastIP).GetAddressBytes());
            socket.SendToAsync(sendEvent);
            t.Start();
            DateTime endTime = DateTime.Now.AddSeconds(searchTimeOut);
            do {
                System.Threading.Thread.Sleep(100);
            } while (DateTime.Now < endTime);
            return results;
        }
    }
}
'@
        }
        #endregion Embedded C# SSDP Finder
    }

    process {
        # If -Force was sent, invalidate the cache
        if ($Force) { $script:CachedDiscoveredNanoLeafs = $null }
        if (-not $script:CachedDiscoveredNanoLeafs) { # If there is no cache, repopulate it.
            $script:CachedDiscoveredNanoLeafs =
                @([StartAutomating.NanoLeafFinder]::new().FindDevices($DeviceType, $SearchTimeout)) |
                    Where-Object {
                        # Write all devices found to Verbose
                        Write-Verbose $_
                        $_ -like '*nanoleaf*' # but only pass down devices that could be rokus.
                    } |
                    ForEach-Object {
                        $headerLines = @($_ -split '\r\n') # Split the header lines
                        [PSCustomObject][Ordered]@{
                            # The IPAddress will be within the Location: header
                            IPAddress = $(
                                $(
                                    $headerLines -like 'LOCATION:*' -replace '^Location:\s{1,}'
                                ) -as [uri] # We can force this into a URI
                            ).DnsSafeHost # At which point the DNSSafeHost will be the IP
                            MACAddress = $(
                                @($headerLines -like 'nl-deviceid:*' -split ': ')[1]
                            )
                            DeviceName = $(
                                @($headerLines -like 'nl-devicename:*' -split ': ')[1]
                            )
                            # Decorate the return type, so it formats correctly.
                            PSTypeName = 'NanoLeaf.Discovery'
                        }

                        # Just doing a quick sanity check here
                        # so we don't emit objects we can't accurately map the IP
                        if ($out.IPAddress -like '*.*') {
                            $out.IPAddress = [IPAddress]$out.IPAddress
                            $out
                        }
                    }
        }
        $script:CachedDiscoveredNanoLeafs # Output the cached value.
    }
}
