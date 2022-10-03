function Set-HueRule
{
    <#
    .Synopsis
        Sets a Hue Rule
    .Description
        Sets a Hue Rule.  Hue Rules are used to automatically change your Hue Lights and devices when conditions occur.
    .Link
        Get-HueRule
    .Link
        Remove-HueRule
    .Example
        Set-HueRule -Condition {
            "/sensors/55/state/status" -eq "1"
        } -Action {
            Set-HueLight -Name "Sunroom*" -ColorTemperature 420
        } -Name BrightenRoom
    .EXAMPLE
        # Set a rule that when 
        Set-HueRule -Condition {
            "/sensors/61/state/buttonevent" -eq "4002"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -Brightness 0.01
        } -Name SunroomDimmerTap
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "4003"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -Off
        } -Name SunroomDimmerHoldDownToTurnOff
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "1003"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -On
        } -Name SunroomDimmerHoldUpToTurnOn
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "1002"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -On -Brightness .8
        } -Name SunroomDimmerTapOn
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "2003"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -BrightnessIncrement .1
        } -Name SunroomDimmerHoldBright
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "2002"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -BrightnessIncrement .05
        } -Name SunroomDimmerTapBright
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "3002"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -BrightnessIncrement -.05
        } -Name SunroomDimmerTapDarken
    .EXAMPLE
        Set-HueRule -Condition {
            "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "3003"
        } -Action {
            Set-HueLight -RoomName "Sunroom" -BrightnessIncrement -.1
        } -Name SunroomDimmerHoldDarken
    #>
    [OutputType([PSObject])]
    [CmdletBinding(SupportsShouldProcess)]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("Test-ForSlowScript", "", Justification="Impact Incidental")]
    param(
    # The name of the rule.
    [Parameter(Mandatory=$true,Position=0)]
    [string]
    $Name,

    # The condition.
    # If the value is a ScriptBlock, only operators and their surrounding conext will be accepted.
    # Each condition should take the form: `"/resource/id/restOfAddress" -operator "value"`.
    # Rules may have more than one condition.
    # If the address is not a resource followed by a digit, the resource will be looked up by name.
    [Parameter(Mandatory,Position=1)]
    [Alias('Conditions')]
    [PSObject[]]
    $Condition,

    # The action.
    # If this value is a Script Block, only commands from this module that have the parameter -OutputInput may be called.
    [ValidateScript({
        
        $MyModule = Get-Module LightScript
        foreach ($act in $_) {
            if ($act -is [ScriptBlock]) { # If the input is a ScriptBlock
                $ast = $act.Ast
                $expr = $ast.FindAll({param($ast) $ast -is [Management.Automation.Language.CommandExpressionAst]}, $true ) # and has no command expressions
                if ($expr) { throw "Action Script cannot use expressions " }
                $foundCmds = $ast.FindAll({param($ast) $ast -is [Management.Automation.Language.CommandAst]}, $true ) # find all commands.
                foreach ($fc in $foundCmds) { # Ensure each command
                    $thecmd = @($fc.CommandElements)[0]
                    if ($theCmd.Value) {
                        if (-not $MyModule.ExportedCommands[$thecmd.Value]) { # comes from this module
                            throw "Action Script Blocks cannot use commands that are not defined in the module"
                        }
                        if (-not $MyModule.ExportedCommands[$theCmd.Value].Parameters.OutputInput) { # and has the -OutputInput parameter.
                            throw "Only commands that support -OutputInput can be used in a rule action"
                        }
                    } else {
                        throw "Action Script Blocks cannot use commands that are not defined in the module"
                    }
                }
            } else {
                foreach ($requirement in 'address', 'method', 'body') { # Otherwise, check for the required properties.
                    if (-not $act.$requirement) {
                        throw "Requirement $requirment not found in action"
                    }
                }
            }
        }
        return $true
    })]
    [Parameter(Mandatory,Position=2)]
    [Alias('Actions')]
    [PSObject[]]
    $Action,

    # If provided, the schedule will only run on the bridge with a particular device ID
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $DeviceID,

    # If provided, the schedule will only run on the bridge found at the provided IP address
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('IP')]
    [IPAddress]
    $IPAddress,

    # If set, will disable the rule.
    [switch]
    $Disable
    )

    begin {
        $myCmd          = $MyInvocation.MyCommand
        $camelCaseSpace = [Regex]::new("(?<=[a-z])(?=[A-Z])")
    }

    process {
        $splat = @{}
        #region Copy Parameters from Get-HueBridge
        $MyParameters = @{} + $psBoundParameters # Copy $PSBoundParameters
        foreach ($in in 'Name','ExactMatch','RegularExpression','ID') {
            if (-not $splat.$in -and $myParameters.$in) {
                $splat.$in = $myParameters.$in
            }
        }
        $RuleExists = Get-HueRule @splat

        #region Translate Condition
        $realCondition = @(foreach ($c in $Condition) {
            if ($c -is [string]) {
                $c
            } elseif ($c -is [ScriptBlock]) {
                $tokens = [Management.Automation.PSParser]::Tokenize($c, [ref]$null)
                for ($i =1 ;$i -lt $tokens.Count;$i++) {
                    $isOperator = $tokens[$i].Type -eq 'operator'
                    if ($isOperator) {
                        $nextToken = $tokens[$i + 1]
                        $previousToken = $tokens[$i -1]
                        $value =
                            if ('String', 'Number' -contains $nextToken.Type) {
                                $nextToken.Content
                            } elseif ( 'Variable' -contains $nextToken.Type) {
                                $ExecutionContext.SessionState.PSVariable.Get($nextToken.Content).Value
                            }
                        $address =
                            if ('String', 'Number' -contains $previousToken.Type) {
                                $previousToken.Content
                            } elseif ( 'Variable' -contains $previousToken.Type) {
                                $ExecutionContext.SessionState.PSVariable.Get($previousToken.Content).Value
                            }

                        if ($value -eq $true -or $value -eq $false) {
                            $value = $value.ToString().ToLower()
                        }

                        if ($address -match '^/(?<R>[^/]+)/(?<N>\D[^/]+)/(?<M>.+)$') {
                            $matchInfo = @{} + $matches
                            $getResourceSplat = @{
                                "$($matches.R)" = $true
                                Name = $matches.N, $camelCaseSpace.Replace($matches.N, '?')
                            }
                            Get-HueBridge @getResourceSplat -WhatIf:$false |
                                ForEach-Object {
                                    [PSCustomObject][Ordered]@{
                                        address = "/$($matchInfo.R)/$($_.Id)/$($matchInfo.M)"
                                        operator = $tokens[$i].Content.TrimStart('-')
                                        value = $value
                                    }    
                                }
                        } else {
                            [PSCustomObject][Ordered]@{
                                address =$address
                                operator = $tokens[$i].Content.TrimStart('-')
                                value = $value
                            }
                        }
                    }
                }
            } else {
                foreach ($_ in $c) {
                    $ht = [Ordered]@{
                        address = $_.Address
                        operator =  $_.operator
                    }
                    if ($_.Value) {
                        $ht.value = $_.value
                    }
                    [PSCustomObject]$ht
                }
            }
        })

        $ConditionWasTerminated = $realCondition | Where-Object { $_.Operator -like 'dx' }
        if (-not $ConditionWasTerminated) {
            $realCondition += New-Object PSObject -Property @{
                address = $realCondition[-1].address
                operator = 'dx'
            }
        }
        #endregion Translate Condition


        #region Translate Action
        $realAction = @(foreach ($a in $Action) {
            if ($a -is [ScriptBlock]) {
                foreach ($func in $myCmd.Module.ExportedFunctions.Values) {
                    if ($func.Parameters.OutputInput) {
                        $global:PSDefaultParameterValues["${func}:OutputInput"] = $true
                    }
                    if ($func.Parameters.WhatIf) {
                        $global:PSDefaultParameterValues["${func}:WhatIf"] = $false
                    }
                }
                & $a | Select-Object @{
                    Name='address';Expression={
                        $parts = @($_.Address -split '/' -ne '')
                        '/' + ($parts[2..$parts.Count] -join '/')}
                    },
                    @{Name='method';Expression={$_.Method}},
                    @{Name='body';Expression={$_.Body}}
                foreach ($func in $myCmd.Module.ExportedFunctions.Values) {
                    if ($func.Parameters.OutputInput) {
                        $global:PSDefaultParameterValues.Remove("${func}:OutputInput")
                    }
                    if ($func.Parameters.WhatIf) {
                        $global:PSDefaultParameterValues.Remove("${func}:WhatIf")
                    }
                }
            } else {
                $a | Select-Object @{Name='address';Expression={$_.Address}},
                    @{Name='method';Expression={$_.Method}},
                    @{Name='body';Expression={$_.Body}}
            }
        })
        #endregion Translate Action

        #region Create or Update Rule
        $restIn = @{name=$Name;conditions=$realCondition;actions=$realAction;status = if ($Disable) { "disabled" } else { "enabled" }}


        if (-not $RuleExists) {
            Get-HueBridge |
                Where-Object {
                    if ($DeviceID -and $_.DeviceID -ne $DeviceID) { return $false }
                    if ($IPAddress -and $_.IPAddress -ne $IPAddress) { return $false }
                    $true
                } |
                Send-HueBridge -Command rules -Method POST -Data $restIn
        } else {
            Get-HueBridge |
                Where-Object {
                    if ($DeviceID -and $_.DeviceID -ne $DeviceID) { return $false }
                    if ($IPAddress -and $_.IPAddress -ne $IPAddress) { return $false }
                    $true
                } |
                Send-HueBridge -Command "rules/$($RuleExists.ID)" -Method PUT -Data $restIn
            Get-HueRule -ID $RuleExists.ID
        }
        #endregion Create or Update Rule
    }
}