$LightScriptLoaded = Get-Module LightScript
if (-not $LightScriptLoaded) {
    $LightScriptLoaded = Get-ChildItem -Recurse -Filter "*.psd1" | Where-Object Name -like 'LightScript*' | Import-Module -Name { $_.FullName } -Force -PassThru
}
if ($LightScriptLoaded) {
    "::notice title=ModuleLoaded::LightScript Loaded" | Out-Host
} else {
    "::error:: LightScript not loaded" |Out-Host
}
if ($LightScriptLoaded) {
    Save-MarkdownHelp -Module $LightScriptLoaded.Name -PassThru
}
