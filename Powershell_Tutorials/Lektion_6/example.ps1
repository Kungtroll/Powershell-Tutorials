Param(
    # Process name
    [Parameter(Mandatory = $true)]
    [String]
    $Processname
)

Get-process $Processname