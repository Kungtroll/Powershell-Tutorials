<#
Felhantering med Try..Catch
ErrorAction
$Error
Throw

#>

#$Error
Function Get-ProcessesFromServer ($Server)
{
    $Utilization = New-Object -TypeName PSCustomObject
    Try 
    {
        $Processes = Invoke-Command -ComputerName $Server -ScriptBlock {Get-Process Explorer} -ErrorAction Stop
        $Utilization | Add-Member -MemberType NoteProperty -Name "Name" -Value $Processes.Name
        $Utilization | Add-Member -MemberType NoteProperty -Name "CPU" -Value $Processes.CPU
    }

    Catch
    {
        $Utilization | Add-Member -MemberType NoteProperty -Name "Name" -Value "Operation Failed"
        $Utilization | Add-Member -MemberType NoteProperty -Name "CPU" -Value "Operation Failed"
        Write-host "Anslutningen misslyckades"
        Throw "Det gick inte att ansluta till $server"
    }

    Finally
    {
        Write-host "Stänger anslutningen"
        Write-Host $Utilization
    }
    Return $Utilization
}

#$Error
Function Get-ProcessesFromServer ($Server)
{
    $Utilization = New-Object -TypeName PSCustomObject
    Try 
    {
        $Processes = Invoke-Command -ComputerName $Server -ScriptBlock {Get-Process Explorer} -ErrorAction Stop
        $Utilization | Add-Member -MemberType NoteProperty -Name "Name" -Value $Processes.Name
        $Utilization | Add-Member -MemberType NoteProperty -Name "CPU" -Value $Processes.CPU
    }

    Catch
    {
        $Utilization | Add-Member -MemberType NoteProperty -Name "Name" -Value "Operation Failed"
        $Utilization | Add-Member -MemberType NoteProperty -Name "CPU" -Value "Operation Failed"
        Write-host "Anslutningen misslyckades"
        Throw "Det gick inte att ansluta till $server"
    }

    Finally
    {
        Write-host "Stänger anslutningen"
        Write-Host $Utilization
    }
    Return $Utilization
}

Format-List (Get-ProcessesFromServer (Read-Host "Välj en host"))
#$Error
#Write-Error skriver till $Error utan att generera ett terminating error
#Throw genererar ett terminating Error
#Throw i en catch kan plocka felmeddelandet från Try.
#Fristående throw behöver en reason: Throw "Det gick inte att ansluta till $server"