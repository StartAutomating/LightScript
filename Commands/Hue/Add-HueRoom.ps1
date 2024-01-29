function Add-HueRoom
{
    <#
    .Synopsis
        Adds rooms or groups to a Hue Bridge.
    .Description
        Adds Hue rooms, groups, or entertainment areas to a Hue Bridge.
    .Example
        Add-HueRoom -Name Office -Light "Office Lightstrip", "Office Desk Light 1", "Office Desk Light 2" -RoomType Office
    .Link
        Get-HueRoom
    .Link
        Remove-HueRoom
    #>
    [OutputType([PSObject])]
    param(
    # The name of the Room or Light Group.
    [Parameter(Mandatory=$true,Position=0,ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # The name of the lights that will be added to the room
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LightName')]
    [string[]]
    $Light,

    # One or more identifiers for lights
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $LightID,

    # If set, will automatically group lights with a similar name as the room.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Switch]
    $AutoGroup,

    # The type of the room
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('Bathroom','Bedroom','Carport','Driveway','Dining',
        'Front door','Garage','Garden','Gym','Hallway','Kids bedroom',
        'Kitchen','Living room','Office','Other','Nursery','Recreation',
        'Terrace','Toilet')]
    [string]
    $RoomType = 'Other',

    # The type of the group, either Room of LightGroup (by default, Room).
    # Rooms cannot share lights with other rooms, while light groups can contain lights already in a room.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('Room','LightGroup', 'Entertainment', 'Zone')]
    [string]
    $GroupType = 'Room'
    )

    begin {
        $myCmd = $MyInvocation.MyCommand
    }

    process {
        $roomExists = Get-HueRoom -Name $Name

        $namedLights = @(if ($light) {  Get-HueLight -Name $Light })
        $IdLights =@(if ($LightID) { Get-HueBridge -Light -ID $LightID })
        $autoGroupLights = @(if ($AutoGroup) { Get-Light -Name "*$Name*"})

        $RoomType =
            foreach ($_ in $myCmd.Parameters['RoomType'].Attributes) {
                if (-not $_.ValidValues) { continue }
                $_.ValidValues -eq $RoomType
                break
            }

        $lightList = @($namedLights + $IdLights + $autoGroupLights | Select-Object -ExpandProperty ID -Unique)

        #region Add Lights to Existing Room
        if ($roomExists) {
            $allLights = @(@($roomExists.Lights) + $lightList| Select-Object -Unique)
            if ($allLights.Count -eq $roomExists.Lights.Count -and $RoomType -eq $roomExists.Class) {
                Write-Verbose "Nothing to change from room $Name"
                return
            }

            foreach ($existingRoom in $roomExists) {
                $existingRoom |
                    Send-HueBridge -Command {"groups/$($_.ID)"} -Method PUT -Data @{
                        lights = $allLights
                        class = $RoomType
                    }
            }
            
        }
        #endregion Add Lights to Existing Room
        #region Create Light Room/LightGroup/Zone/EntertainmentArea
        else {
            if ($GroupType -eq 'Room') {
                Get-HueBridge |
                    Send-HueBridge -Command groups -Method POST -Data @{
                        lights = $lightList
                        class = $RoomType
                        type = 'Room'
                        name = $Name
                    }
            } else {
                Get-HueBridge |
                    Send-HueBridge -Command groups -Method POST -Data @{
                        lights = $lightList
                        type = $GroupType
                        name = $Name
                    }
            }
        }
        #endregion Create Light Room/LightGroup
    }
}

