[CmdletBinding()]
param (
    [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
    [Microsoft.ActiveDirectory.Management.ADAccount[]]
    $Computers,

    [Parameter(Mandatory = $false, Position = 0)]
    [String]$Drive = "C"
)

Begin {
    $ArrSpace = @()
    }
Process {
    $SpaceInfo = Invoke-Command -ComputerName $Computers.Name -ScriptBlock {Get-PSDrive $Using:Drive}
    $ArrSpace += $SpaceInfo
    }
End 
{
   $ArrSpace | Sort-Object -Property Free
}