[uri]("https://developer.lametric.com/content/apps/icon_thumbs/$(
    $this.IconID -replace '\D'
)$(
    if ($this.IconType -eq '1') { ".gif"} else { ".png"}
)")