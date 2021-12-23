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
    #>
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("Test-ForSlowScript", "", Justification="Impact Incidental")]
    param(
    # The name of the rule.
    [Parameter(Mandatory=$true,Position=0)]
    [string]
    $Name,

    # The condition.
    # If the value is a ScriptBlock, only operators and their surrounding conext will be accepted.
    [Parameter(Mandatory=$true,Position=1)]
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
    [Parameter(Mandatory=$true,Position=2)]
    [PSObject[]]
    $Action,

    # If provided, the schedule will only run on the bridge with a particular device ID
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    $DeviceID,

    # If provided, the schedule will only run on the bridge found at the provided IP address
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('IP')]
    [IPAddress]
    $IPAddress,

    # If set, will disable the rule.
    [switch]
    $Disable
    )

    begin {
        $myCmd = $MyInvocation.MyCommand
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

                        [PSCustomObject][Ordered]@{
                            address =$address
                            operator = $tokens[$i].Content.TrimStart('-')
                            value = $value
                        }
                    }
                }
            } else {
                foreach ($_ in $c) {
                    $ht = @{
                        address = $_.Address
                        operator =  $_.operator
                    }
                    if ($_.Value) {
                        $ht.value = $_.value
                    }
                    $ht
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

        }
        #endregion Create or Update Rule
    }
}