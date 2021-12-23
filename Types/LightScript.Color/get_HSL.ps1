if ($this.Hue -or $this.Saturation -or $this.Luminance) {
    "H{0}°S{1}%L{2}%" -f $this.Hue, $this.Saturation, $this.Luminance
} elseif ($this.Red -or $this.Green -or $this.Blue) {
    $o = $this.RgbToHSL($this.Red, $this.Green, $this.Blue)
    "H{0}°S{1}%L{2:}%" -f [Math]::Round($o.Hue), [Math]::Round($o.Saturation * 100), [Math]::Round($o.Luminance * 100)
}
