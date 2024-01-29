function Rename-HueLight
{
    <#
    .Synopsis
        Renames Hue Lights
    .Description
        Renames one or more Hue lights.
    .Example
        Rename-HueLight
    .Link
        Get-HueBridge
    .Link
        Get-HueLight
    #>
    [OutputType([PSObject])]
    param(
    # The old name of the light.  This can be a wildcard or regular expression.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('ID')]
    [string]
    $OldName,

    # The new name of the light.  A number sign will be replaced with the match number.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string]
    $NewName
    )

    begin {
        $lights = Get-HueLight
        $bridges = Get-HueBridge
    }

    process {
        $lights |
            Where-Object {
                #region Find matching lights
                ($_.Id -eq $oldName) -or
                ($_.Name -like $OldName) -or 
                ($oldName -as [regex] -and $_.Name -match $oldName)                
                #endregion Find matching lights
            } |
            ForEach-Object -Begin {
                $matchCount = 0
            } -Process {
                #region Rename the lights
                $MatchCount++
                $realNewName = $NewName -replace '#', $MatchCount
                $lightToRename = $_
                $bridges | Send-HueBridge -Command "lights/$($lightToRename.id)" -Method PUT -Data @{name=$realNewName}
                #endregion Rename the lights
            }
    }
}
