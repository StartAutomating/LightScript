Write-FormatView -TypeName 'Hue.Capabilities' -Property Lights, Sensors, Groups, Scenes, schedules, Rules, ResourceLinks, Streaming -AsList -VirtualProperty @{
    Lights = { '' + ($_.lights.total - $_.lights.available) + '/' + $_.lights.total }
    Groups = { '' + ($_.groups.total - $_.groups.available) + '/' + $_.groups.total }
    Sensors = { '' + ($_.sensors.total - $_.Sensors.available) + '/' + $_.Sensors.total }    
    schedules = { '' + ($_.schedules.total - $_.schedules.available) + '/' + $_.schedules.total }    
}
