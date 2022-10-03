function Add-HueLight {
<#
    .SYNOPSIS
        Adds lights to Hue
    .DESCRIPTION
        Adds new lights to a Hue Bridge.
    .EXAMPLE
        Add-HueLight # Search for new lights
    .EXAMPLE
        Add-HueLight -DeviceID $serialNumber # Add a new light by serial number.
    .EXAMPLE
        Add-HueLight        # Search for new lights
        Get-HueLight -New   # Get-HueLight -New will return the new lights
    .LINK
        Get-HueLight
    .LINK
        Set-HueLight
    
#>
    
    [CmdletBinding(SupportsShouldProcess)]
    param(
# One or more Device Identifiers (serial numbers ).
        # Use this parameter when adding lights that have already been assigned to another bridge.
        [Alias('SerialNumber')]
        [string[]]
        $DeviceID
    )
    begin {
        $hueBridge = Get-HueBridge
        $invokeParams = @{}
        $invokeParams.IPAddress = $hueBridge.IPAddress
        $invokeParams.HueUserName = $hueBridge.HueUserName
    
        function ConvertRestInput {
                    param([Collections.IDictionary]$RestInput = @{}, [switch]$ToQueryString)
                    foreach ($ri in @($RestInput.GetEnumerator())) {
                        
                        $restParameterValue = $ri.Value
                        $restParameterValue = 
                            if ($restParameterValue -is [DateTime]) {
                                $restParameterValue.Tostring('o')
                            }
                            elseif ($restParameterValue -is [switch]) {
                                $restParameterValue -as [bool]
                            }
                            else {
                                if ($ToQueryString -and 
                                    $restParameterValue -is [Array] -and 
                                    $JoinQueryValue) {
                                    $restParameterValue -join $JoinQueryValue
                                } else {
                                    $restParameterValue
                                }
                            }
                            
                        $RestInput[$ri.Key] = $restParameterValue
                    }
                    $RestInput
                
        }
    
}
process {
    $InvokeCommand       = 'Send-HueBridge'
    $invokerCommandinfo  = 
        $ExecutionContext.SessionState.InvokeCommand.GetCommand('Send-HueBridge', 'All')
    $method              = 'POST'
    $contentType         = 'application/json'
    $bodyParameterNames  = @('DeviceID')
    $queryParameterNames = @('')
    $joinQueryValue      = ''
    $uriParameterNames   = @('')
    $endpoints           = @("lights")
    $ForEachOutput = {
        
    }
    if ($ForEachOutput -match '^\s{0,}$') {
        $ForEachOutput = $null
    }    
    if (-not $invokerCommandinfo) {
        Write-Error "Unable to find invoker '$InvokeCommand'"
        return        
    }
    if (-not $psParameterSet) { $psParameterSet = $psCmdlet.ParameterSetName}
    if ($psParameterSet -eq '__AllParameterSets') { $psParameterSet = $endpoints[0]}    
        $uri = $endpoints[0]
    
    $invokeSplat = @{}
    $invokeSplat.Uri = $uri
    if ($method) {
        $invokeSplat.Method = $method
    }
    if ($ContentType -and $invokerCommandInfo.Parameters.ContentType) {        
        $invokeSplat.ContentType = $ContentType
    }
    if ($InvokeParams -and $InvokeParams -is [Collections.IDictionary]) {
        $invokeSplat += $InvokeParams
    }
    $completeBody = [Ordered]@{}
    foreach ($bodyParameterName in $bodyParameterNames) {
        if ($bodyParameterName) {
            if ($PSBoundParameters.ContainsKey($bodyParameterName)) {
                $completeBody[$bodyParameterName] = $PSBoundParameters[$bodyParameterName]
            } else {
                $bodyDefault = $ExecutionContext.SessionState.PSVariable.Get($bodyParameterName).Value
                if ($null -ne $bodyDefault) {
                    $completeBody[$bodyParameterName] = $bodyDefault
                }
            }
        }
    }
    $completeBody = ConvertRestInput $completeBody
    $bodyContent = 
        if ($ContentType -match 'x-www-form-urlencoded') {
            @(foreach ($bodyPart in $completeBody.GetEnumerator()) {
                "$($bodyPart.Key.ToString().ToLower())=$([Web.HttpUtility]::UrlEncode($bodyPart.Value))"
            }) -join '&'
        } elseif ($ContentType -match 'json' -or -not $ContentType) {
            ConvertTo-Json $completeBody
        }
    if ($bodyContent -and $method -ne 'get') {
        $invokeSplat.Body = $bodyContent
    }    
    Write-Verbose "$($invokeSplat.Uri)"
    if ($ForEachOutput) {
        if ($ForEachOutput.Ast.ProcessBlock) {
            & $invokerCommandinfo @invokeSplat | & $ForEachOutput
        } else {
            & $invokerCommandinfo @invokeSplat | ForEach-Object -Process $ForEachOutput
        }        
    } else {
        & $invokerCommandinfo @invokeSplat
    }
}
}

