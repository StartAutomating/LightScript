This directory contains LightScript's functions for [Elgato Key Light](https://www.elgato.com/us/en/p/key-light).

> [Don't have an Elgato Key Light?](https://amzn.to/4betQc7)

~~~PipeScript {
    Import-Module ../../LightScript.psd1 -Global
    [PSCustomObject]@{
        Table = Get-Command -Module LightScript | 
            Where-Object { $_.ScriptBlock.File -like "$pwd*" } |
            .Name .Verb .Noun .Source {
                $relativePath = $_.ScriptBlock.File.Substring("$pwd".Length) -replace '^[\\/]'
                "[$relativePath]($relativePath)"
            }
    }
    
}
~~~