Param 
    (
    [parameter(Mandatory=$true)][Int32]$Tal1,
    [parameter(Mandatory=$true)][string]$Operator,
    [parameter(Mandatory=$true)][Int32]$Tal2    
    )

Switch ($Operator.ToLower())
{
    "+" {$Tal1 + $Tal2}
    "-" {$Tal1 - $Tal2}
    "*" {$Tal1 * $Tal2}
    "x" {$Tal1 * $Tal2}
    "/" {$Tal1 / $Tal2}
    Default {Write-Host "Ingen korrekt operator angiven, vänligen skriv +, -, * eller /"; Exit}
}

Return