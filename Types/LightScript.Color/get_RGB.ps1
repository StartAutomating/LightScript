if ($this.Red -or $this.Green -or $this.Blue) {
    "#{0:x2}{1:x2}{2:x2}" -f $this.Red, $this.Green, $this.Blue
} elseif ($this.Hue -or $this.Saturation -or $this.Luminance) {
    $o = $this.HSLToRgb($this.Hue, $this.Saturation, $this.Luminance)
    "#{0:x2}{1:x2}{2:x2}" -f $o.Red, $o.Green, $o.Blue
}