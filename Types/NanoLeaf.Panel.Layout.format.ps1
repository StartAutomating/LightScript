Write-FormatView -TypeName NanoLeaf.Panel -Property PanelID, X, 
    Y, O, ShapeType -GroupByScript {
        $_.ControllerName + ' [ ' + $_.IPAddress + ' ] '
    } -GroupLabel "Controller"