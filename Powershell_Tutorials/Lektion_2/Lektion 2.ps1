<# 

Repetition från Lektion 1:

Datyper: Int, string, boolean, single, datetime, xml, array, hashtable

Objekt:
Object - Methods & Properties
$objectname.methodname
$objectname.propertyname
$objectname.gettype()
$objectname | get-member

Stränghantering

ForEach

Foreach ($number in $numbers)
    {
    write-host $number -ForegroundColor Green
    }

# I pipeline

$Numbers | %($_){write-host $_ -ForegroundColor Green}

Export-csv / Import-csv
Select-Object -Expandproperty

#>




<#
Lektion 2

Gå igenom uppgiften från Lektion 1
If, ElseIf, Else
Switch
Do..While
Read-Host
Write-Host

Uppgift till nästa gång

(Funktioner)
#>

$Tal = Read-Host "Skriv ett Tal"

If ($Tal -lt 10) 
    {
    Write-Host "Talet är mindre än 10"
    }
    ElseIf ($Tal -eq 10)
    {
    Write-Host "Talet är 10"
    }
    Else
    {
    Write-Host "Talet är större än 10"
    }

#Switch

Switch (Read-Host "Skriv ett Tal mellan 1-5")
    {
       1 {Write-Host "Talet är 1"}
    
       2 {Write-Host "Talet är 2"}

       3 {Write-Host "Talet är 3"}

       4 {Write-Host "Talet är 4"}

       5 {Write-Host "Talet är 5"}
       default 
       {
       Write-Host "Talet ligger inte mellan 1-5" ;Break
       }
    }


#While
$a = 1

DO
    {
    "Loop $a"
    $a++
    "Now `$a is $a"
    } 
    While ($a -lt 5)

#Eller en do-while med en if-else inuti

$Sant = $False
Do 

{
    $Answer = Read-Host "Vilken är Mexicos Huvudstad?"
    If ($Answer -eq "Mexico City") 
        {
        $Sant = $True
        write-Host "Rätt Svar!"
        }
    Else 
        {
        $Sant = $False
        write-host "Fel svar, försök igen!"
        }
}

While ($Sant -ne $True)


# Funktioner
# En funktion är egentligen samma sak som ett objekts metod.
# Funktionen kan ta emot inparametrar och kan returnera information
# Funktioner begränsar "scope" för variabler, en variabel som används i en funktion
# är inte tillgänglig utanför funktionen.
# Vi nosar bara lite på detta idag, då det finns ganska mycket mer att veta om funktioner.

Function WriteMyName ($name)
    {
        $Halsning = "Hej " + $Name
        Return $Halsning
    }

$Myname = read-host "Vad heter du?"
write-host -ForegroundColor Green (WriteMyName $Myname)