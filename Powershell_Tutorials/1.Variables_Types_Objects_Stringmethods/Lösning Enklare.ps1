$Servers = Import-Csv -Path .\ServersCleaned.csv
$ServersOut =@()
ForEach($Server in $Servers)
    {
    $ObjServer = Get-AdComputer $Server.Name -Properties IPv4Address | Select-Object Name,IPv4Address
    $ServersOut += $ObjServer
    }
$ServersOut | Export-Csv -Path .\ServersOut.csv -NoTypeInformation -Delimiter ";" 