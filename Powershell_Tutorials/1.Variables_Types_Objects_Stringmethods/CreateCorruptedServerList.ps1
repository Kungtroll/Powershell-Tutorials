$Servers = Get-ADComputer -Filter {Operatingsystem -Like "*server*" -and Created -gt "2018-12-15 00:00:00"} -Properties CN,OperatingSystem,Created

$ListServers =@()

ForEach ($Server in $Servers)
    {
    $Noise = $Null
    $StrLen = (3..5) | Get-Random -Count 1
    $Noise = -join ((65..90) + (97..122) | Get-Random -Count $StrLen | % {[char]$_})
    $Trashname = $Noise.ToString() + "#" + $Server.Name
    $ObjServer = New-Object -TypeName psobject 
    
    Add-Member -InputObject $ObjServer -MemberType NoteProperty -Name "Name" -Value $Trashname
    #Add-Member -InputObject $ObjServer -MemberType NoteProperty -Name "Created" -Value $Server.Created
    $ListServers += $ObjServer

    }
    $ListServers
    $ListServers | Export-Csv -Delimiter ";" -LiteralPath .\Servers.csv -NoTypeInformation