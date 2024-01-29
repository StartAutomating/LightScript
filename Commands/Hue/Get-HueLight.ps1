function Get-HueLight
{
    <#
    .Synopsis
        Gets Hue lights
    .Description
        Gets Hue lights from the Hue Bridge.
    .Example
        Get-HueLight
    .Link
        Get-HueBridge
    #>
    [OutputType([PSObject])]
    [CmdletBinding(DefaultParameterSetName='All')]
    param(
    # The name of the light
    [Parameter(Mandatory,ParameterSetName='ByName',Position=0)]
    [Alias('LightName')]
    [string[]]
    $Name,

    # If set, will match patterns as regular expressions
    [switch]
    $RegularExpression,

    # If set, will only match exact text
    [switch]
    $ExactMatch,

    # The name of the room.
    [Parameter(Mandatory,ParameterSetName='Room')]
    [Alias('RoomName')]
    [string[]]
    $Room,

    # The light ID.
    [Parameter(Mandatory,ParameterSetName='ID',ValueFromPipelineByPropertyName)]
    [int]
    $LightID,

    # If set, will get recently added lights.
    [Parameter(Mandatory,ParameterSetName='New',ValueFromPipelineByPropertyName)]
    [switch]
    $New
    )

    process {
        if ($new) {
            Get-HueBridge | Send-HueBridge -Command 'lights/new'
            return
        }

        if ($Room) {
            #region Get Lights in a Room
            $RoomSplat = @{Name=$Room}
            $theRooms = Get-HueBridge -Room @RoomSplat

            $theRooms |
                Send-HueBridge -Command { "groups/$($_.ID)" } -Method GET -PSTypeName Hue.Light
            #endregion Get Lights in a Room
            return
        } elseif ($LightID) {
            #region Get Specific ligts
            Get-HueBridge |
                Send-HueBridge -Command { "lights/$LightID" } -Method GET -PSTypeName Hue.Light
            #endregion Get Specific ligts
            return
        }



        Get-HueBridge -Light @PSBoundParameters
    }

}
