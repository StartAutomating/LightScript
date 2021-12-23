try { 
    [Convert]::FromBase64String($this.ManufacturerName) 
} catch {
    if ($this.ManufacturerName) {
        $this.ManufacturerName
    } else {
        ''
    }
}
