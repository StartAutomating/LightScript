:ToIncludeFiles foreach ($file in (Get-ChildItem -Path "$PSScriptRoot" -Filter "*-*.ps1" -Recurse)) {
    if ($file.Extension -ne '.ps1')      { continue }  # Skip if the extension is not .ps1
    foreach ($exclusion in '\.[^\.]+\.ps1$') {
        if (-not $exclusion) { continue }
        if ($file.Name -match $exclusion) {
            continue ToIncludeFiles  # Skip excluded files
        }
    }     
    . $file.FullName
}

if ($home) {
    $Script:KnownResources =
        @(
            Get-HueLight
            Get-HueRoom
            Get-NanoLeaf
        )

    foreach ($resource in $Script:KnownResources) {
        if ($resource.pstypenames -contains 'Hue.Light') {
            Set-Alias -Name ($resource.Name -replace '\s') -Value Set-HueLight
        }
        if ($resource.pstypenames -contains 'Hue.Group' -or
            $resource.pstypenames -contains 'Hue.LightGroup') {
            Set-Alias -Name ($resource.Name -replace '\s') -Value Set-HueLight
        }
    }
}

$LightScript = $MyInvocation.MyCommand.ScriptBlock.Module
$LightScript.pstypenames.insert(0,'LightScript')

Export-ModuleMember -Function * -Alias * -Variable LightScript
