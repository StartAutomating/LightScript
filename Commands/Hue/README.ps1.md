This directory contains LightScript's functions for [Philips Hue Bridges](https://www.philips-hue.com/).

> Don't have a Hue Bridge? [Buy On Amazon](https://amzn.to/4bguVQO)
<blockquote>
    <details>
        <summary>Want more Hue?</summary>
        <ul>
            <li>
                <a href='https://amzn.to/4bepXE3'>Gradient LightStrip</a>
            </li>
            <li>
                <a href='https://amzn.to/3QlYSXB'>Candlelights</a>
            </li>
            <li>
                <a href='https://amzn.to/3Up1THA'>Color Bulbs</a>
            </li>
            <li>
                <a href='https://amzn.to/4di8igy'>Smart Dimmer Switch</a>
            </li>
        </ul>
    </details>
</blockquote>

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