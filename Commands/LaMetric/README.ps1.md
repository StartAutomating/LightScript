This directory contains LightScript's functions for [LaMetric Time](https://lametric.com/en-US).

> [Don't have a LaMetric Time?](https://amzn.to/44p3HF6)

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