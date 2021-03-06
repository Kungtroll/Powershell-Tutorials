﻿Break
<#
Skapa ett enkelt PSCustomObject med New-Object
New-Object
Add-Member

Class
Enum
#>

# Vi har tidigare pratat om Objekt och att dessa är fundamentalt viktiga i Powershell
# Objekten är ett bra sätt att hantera sin input och Output på och kan användas för att skicka parametrar
# eller data till cmdlets. Ett exempel är funktionen Export-CSV som vill ha en array med objekt som input.
# Därför ska vi prata lite om hur man enkelt kan skapa och forma sina egna objekt.
# Det finns många sätt att göra detta på, och man kan även skapa egna klasser, men idag ska vi nöja oss med
# att skapa ett objekt av klassen PSCustomObject.

#Ett enkelt sätt att göra detta är att använda New-Object

$MittObjekt = New-Object -TypeName PSCustomObject

$MittObjekt | Get-Member

#Nu fick vi en type (TypeName) - det vill säga klass. 
#Det är en .Net klass, Powershell bygger på .Net, precis som språk som:
# C#, J#, F#, VB.Net., C++/CLI, Managed C++, IronPython etc...
#Språken har alltså mycket gemensamt vilket gör det lättare för oss att
#vid behov lära oss nästa språk i .Net familjen.

[System.Management.Auto] #Ctrl + Space
#Nu kan vi browsa i klasserna

[System.Management.Automation.PSCustomObject]
#Lägg till :: så kan du se metoder.
[System.Management.Automation.PSCustomObject]::Equals #Enter
#Constructor: static bool Equals(System.Object objA, System.Object objB)
#Vad betyder detta?
#Metoden returnerar en static bool, d.v.s. en True Eller False
#Input för metoden är System.Object objA, objB
#Sammanfattat:
#Den kan alltså jämföra objA med ObjB och returnera en
#True eller False.



#Nog om .Net, tillbaka till powershell
#och PScustom objektet vi skapade - $MittObjekt

#För att lägga till properties till objektet använder vi Add-Member 
# Ni minns väl att vi använde Get-Member för att titta på vilka methods & Properties ett objekt har.

Add-member -InputObject $MittObjekt -MemberType NoteProperty -Name "Color" -Value "Green"
Add-member -InputObject $MittObjekt -MemberType NoteProperty -Name "Text" -Value "Ett objekt"
write-host $MittObjekt.Text -ForegroundColor $MittObjekt.Color



#Eller med pipe | för den som vill
$MittAndraObjekt = New-Object -TypeName PSCustomObject
$MittAndraObjekt | Add-member -MemberType NoteProperty -Name "Color" -Value "Red"
$MittAndraObjekt | Add-member -MemberType NoteProperty -Name "Text" -Value "Ett objekt från pipe"
write-host $MittAndraObjekt.Text -ForegroundColor $MittAndraObjekt.Color

#Det går att lägga till fler properties till objektet med Add-member
#För att Spara våra två objekt till en array kan vi helt enkelt använda +=
$MinArrayAvObjekt = @()
$MinArrayAvObjekt += $MittObjekt
$MinArrayAvObjekt += $MittAndraObjekt

ForEach ($Objekt in $MinArrayAvObjekt){
    write-host $Objekt.Text -ForegroundColor $Objekt.Color
}
#På samma sätt kan jag bygga en ny Array av Objekt med värden från andra objekt

$MinAndraArrayAvObjekt = @()
ForEach ($Objekt in $MinArrayAvObjekt){
    $Objekt2 = New-Object -TypeName PSCustomObject
    $Objekt2 | Add-member -MemberType NoteProperty -Name "Text" -Value $Objekt.Text
    $Objekt2 | Add-member -MemberType NoteProperty -Name "Color" -Value $Objekt.Color
    $Objekt2 | Add-member -MemberType NoteProperty -Name "NyProperty" -Value "Ett värde från något annat objekt"
    $MinAndraArrayAvObjekt += $Objekt2
}
$MinAndraArrayAvObjekt

#Skapa en egen klass

#Man kan skapa Custom property types istället för String, Int, etc.
#De kallas för Enum - eller enumerator och låter oss specificera
#en lista över vilka värden som är giltiga i den propertyn.
Enum Color{
    Red
    Green
    Blue
    Yellow
    Black
    White
}


Class Car{
    #Properties
    [String]$PlateNumber
    static [String]$Name = 'Gamla bettan'
    [int]$numberOfDoors
    [datetime]$year
    [String]$model
    [Color]$Color
    [String]$Direction

    #Skapa en metod för klassen
    [void]TurnCar ([String]$Arg){
        $This.Direction = $Arg
    }
}

#Instansiera till ett objekt
$MinVolvo = New-Object Car
#Går också att göra med .Net
$MinVolvo = [Car]::New()
#Ge objektets properties värden
$MinVolvo.PlateNumber = "1337Mobile"
$MinVolvo.numberOfDoors = 5
$MinVolvo.year = '2010-01-01 00:00:00'
$MinVolvo.model = "V70"
$MinVolvo.Color = 'Red'
$MinVolvo.Direction = 'Forward'
$MinVolvo

#Vilken riktning åker bilen?
$MinVolvo.Direction
#Sväng vänster
$MinVolvo.TurnCar("Left")
#Vilken riktning åker bilen nu?
$MinVolvo.Direction

#Vi satte namnet till en static, ett värde som aldrig ändras
#En static kan man se på följande sätt 
$MinVolvo::Name

#Static används t.ex. på metoder som man inte behöver instatiera
#för att kunna använda. T.ex. Math
[System.Math]::Floor(3.14)
#Metoden gör uträkningen åt oss utan att vi behöver skapa ett Math objekt. 

# Felhantering
Function Get-User ($User){
    Try{
        $ObjUser = Get-ADUser $User -ErrorAction Stop
    }Catch{
        #$Error
        Write-host "Kunde inte hitta kontot"
        Throw "Exiting..."
    }

    Return $objUser
}

Get-User -User "Kalle"
