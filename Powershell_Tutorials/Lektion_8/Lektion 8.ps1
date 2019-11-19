<#

Build a function that accepts pipeline input

ForEach (vi ska fortsätta traggla den)
Try-Catch (Finally)
ErrorAction
If-Else

Bygga en kollektion av Objekt som vi skickar med pipeline till export-csv

Importera objekt med import-csv och skicka till vår funktion med pipeline

#>

#The Pipeline Magic!
Get-ChildItem -File | Measure-Object -Property Length -Average -Sum -Maximum -Minimum

Get-AdUser -filter{GivenName -eq "Peter" -and SurName -Like "Östman"}
Get-AdUser -filter{GivenName -eq "Peter" -and SurName -Like "Östman"} | Export-Csv MyUsers.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8
Import-Csv -Delimiter ";" -Path MyUsers.csv

#Let's demystify!

#Structure of a function that accepts pipeline input.
[CmdletBinding()]
param (
    [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
    [Valuetype]
    $ParameterName
)

Begin {
    #Prepare stuff before starting to process the pipeline. 
    #(Check dependencies, import modules or open a session somewhere)
}

Process{
    #Start doing stuff with objects coming in from the pipeline
    #This is your "main" script
}
End {
    #Clean up after the pipeline has been processed. (Perhaps close a session)
}


.\Generate-serverlist.ps1 | .\Ping-computers.ps1 -username "PoshUser"
.\Generate-serverlist.ps1 | export-csv -Path MyComputers.csv
Import-Csv -Path MyComputers.csv | .\Ping-computers.ps1 -username "PoshUser"
