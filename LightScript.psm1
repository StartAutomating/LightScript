foreach ($file in (Get-ChildItem -Path "$PSScriptRoot" -Filter "*-*.ps1" -Recurse)) {
    if ($file.Extension -ne '.ps1')      { continue }  # Skip if the extension is not .ps1
    if ($file.Name -match '\.[^\.]+\.ps1$') { continue }  # Skip if the file is an unrelated file.
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

