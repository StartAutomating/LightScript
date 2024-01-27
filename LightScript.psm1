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

$LightScript = $MyModule = $MyInvocation.MyCommand.ScriptBlock.Module
$LightScript.pstypenames.insert(0,'LightScript')

New-PSDrive -Name $MyModule.Name -PSProvider FileSystem -Scope Global -Root $PSScriptRoot -ErrorAction Ignore
. ([ScriptBlock]::Create("function $($MyModule.Name): { Push-Location $($myModule.Name): }"))

if ($home) {
    $MyModuleProfileDirectory = Join-Path $home $MyModule.Name
    if (-not (Test-Path $MyModuleProfileDirectory)) {
        $null = New-Item -ItemType Directory -Path $MyModuleProfileDirectory -Force
    }
    New-PSDrive -Name "My$($MyModule.Name)" -PSProvider FileSystem -Scope Global -Root $MyModuleProfileDirectory -ErrorAction Ignore
    . ([ScriptBlock]::Create("function My$($MyModule.Name): { Push-Location My$($myModule.Name): }"))
}

Export-ModuleMember -Function * -Alias * -Variable LightScript
