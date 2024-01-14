[include("*-*.ps1")]$PSScriptRoot

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

$MyModuleProfileDirectory =  $profile | Split-Path | Join-Path -ChildPath $MyModule.Name
if (-not (Test-Path $MyModuleProfileDirectory)) {
    $null = New-Item -ItemType Directory -Path $MyModuleProfileDirectory -Force
}
New-PSDrive -Name "My$($MyModule.Name)" -PSProvider FileSystem -Scope Global -Root $MyModuleProfileDirectory -ErrorAction Ignore

Export-ModuleMember -Function * -Alias * -Variable LightScript