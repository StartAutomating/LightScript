function Search-LaMetricIcon {

    <#
    .SYNOPSIS
        Searchs for LaMetricIcons
    .DESCRIPTION
        Searches for icons for LaMetric Time and other LaMetric devices.
    .EXAMPLE
        Search-LaMetricIcon "PowerShell"
    .LINK
        Get-LaMetricTime
    #>    
    param(
    # The name of the icon we are searching for
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('Title','Query','Name')]
    [string]
    $IconName,

    # The page count.  By default, zero.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $Page = 0,

    # The page size.  By default, 100.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $PageSize = 100
    )

    process {
        $queryString = "search=$IconName&count=$pageSize&page=$page"
        Invoke-RestMethod ('https://developer.lametric.com/api/v1/dev/preloadicons?',$queryString,'' -join '') |            
            & { process {
                foreach ($icon in $_.Icons) {
                    [PSCustomObject][Ordered]@{
                        PSTypeName = 'LaMetric.Icon'
                        Name       = $icon.name
                        IconId     = "$(if ($icon.Type -eq 0) { 'i'} else { 'a'})$($icon.id)"
                        IconType   = $icon.type
                        Category   = $icon.category
                        CreatorID  = $icon.creator                        
                        Version    = $icon.Version
                    }                    
                }
            } } | 
            Sort-Object Category
    }

}
