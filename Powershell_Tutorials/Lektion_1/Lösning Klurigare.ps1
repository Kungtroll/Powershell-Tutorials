$Servers = Import-Csv -Path .\Servers.csv
$ServersOut =@()
ForEach($Server in $Servers)
    {
    $Servername = $Server.Name.Split("#")[1]
    $ObjServer = Get-AdComputer $Servername -Properties IPv4Address | Select-Object Name,IPv4Address
    $ServersOut += $ObjServer
    }
$ServersOut | Export-Csv -Path .\ServersOut.csv -NoTypeInformation -Delimiter ";" 