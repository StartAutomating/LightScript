Write-FormatView -TypeName Hue.Group -Property ID, Name, Type, Lights -VirtualProperty @{
    Lights = { 
        $group = $_
        $lightlist = $_.Lights -join ',' 
        if (-not $script:CachedLightNames) {
            $script:CachedLightNames = @{}
            
        }
        if (-not $script:CachedLightNames[$lightlist]) {
            $script:CachedLightNames[$lightlist] = $group.Lights | Get-HueLight -LightID { $_ } | Select-Object -ExpandProperty Name
        }        
        $script:CachedLightNames[$lightlist] -join [Environment]::NewLine
    }
} -Wrap -Width 4, 20, 15
