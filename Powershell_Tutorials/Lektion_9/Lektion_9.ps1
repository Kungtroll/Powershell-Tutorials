$computers = get-adcomputer -filter {name -like "Server1" -or name -like "Server2" -or name -like "Server3"}
$computers.gettype()
#Microsoft.ActiveDirectory.Management.ADAccount

get-adcomputer -filter {name -like "Server1" -or name -like "Server2" -or name -like "Server3"} | .\Get-diskspace.ps1

$computers | .\Get-diskspace.ps1