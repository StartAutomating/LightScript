This directory and it's subdirectories contain the functions defined in LightScript.

~~~PipeScript {
    Import-Module ../LightScript.psd1
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