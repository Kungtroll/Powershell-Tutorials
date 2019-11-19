<#
Lektion 3

Gå igenom uppgift från förra veckan.

Funktioner

(Param, Begin Process, End)
#>


<# Funktioner

 En funktion är egentligen nästan samma sak som ett objekts metod.
 Funktionen kan ta emot inparametrar och kan returnera information
 Funktionen returnerar all konsolloutput i powershell, inte bara det värde man skriver efter Return.

 I nedan exempel så skulle $b lika bra kunnat stå på raden ovanför och Return utan någon variabel,
 resultatet skulle bli detsamma.
 #>

 Function Test
    {
        $a = 1
        $b = 2

        $a
        Return $b
    }
    Write-host (Test) -ForegroundColor Green
<#
 Funktioner begränsar "scope" för variabler, en variabel som används i en funktion
 är inte tillgänglig utanför funktionen om den inte är deklarerad som "global" eller "script".
 Därför kan det vara klokt att inte använda samma variabelnamn inom och utom funktionen för att
 undvika förvirrning och eventuella bieffekter.

 function [<scope:>]<name> [([type]$parameter1[,[type]$parameter2])]{
 
    param([type]$parameter1 [,[type]$parameter2])
    dynamicparam {<statement list>}
 
    begin {<statement list>}
    process {<statement list>}
    end {<statement list>}
 
}

 Funktionernas egna scope kan också begränsas till scriptet om dessa inte deklareras som global
  Exempel
#>
 Function Global:Restart-Servers ($Serverlist)
    {
    #Här ska koden stå
    $ListServerStatus = @()
    ForEach ($Server in $Serverlist)
        {
        Try
            {
            invoke-command $Server {Restart-computer}
            $ListServerStatus += ($Server+"Rebooted")
            }
        Catch
            {
            $ListServerStatus += ($Server+"Failed")
            }       
        }

    #Vi kan returnera en lista på vilka servrar som kunde startas om i en till array. 
    Return $ListServerstatus
    }

$Servers =@("server1","server2","server3")
$Rebootstatus = Restart-Servers($Servers)

<#
Parametrar kallas även argument.
När man deklarerar funktionens parametrar/argument kan man också välja datatyp (om man vill)
Då kommer inte funktionen försöka köra om den inte får rätt format på argumenten.

Parametrarna kan deklareras inne i funktionen med Param 
#>
Function Get-Coffee
{
    Param ($Strength, [Boolean]$Milk)

    Process
        {
        Write-host $Strength "Coffee, Milk:" $Milk -ForegroundColor Green
        }
}

# likväl som att deklareras på samma rad som funktionens namn: 

Function Get-Coffee ($Strength, [Boolean]$Milk)
{
    Process
        {
        Write-host $Strength "Coffee, Milk:" $Milk -ForegroundColor Green
        }
}

#Att kalla på funktionen, argumenten (parameters) efter varandra med mellanslag

Get-Coffee "Strong" $True

#Eller genom att specificera parametermatchning

Get-Coffee -Strength Strong -Milk $True

#Ett annat exempel på hur man kan kalla på en funktion, här görs en read-host för
# att skicka argument till funktionen.

Function WriteMyName ($name)
    {
        $Halsning = "Hej " + $Name
        Return $Halsning
    }

$Myname = read-host "Vad heter du?"
write-host -ForegroundColor Green (WriteMyName $Myname)

<# Funktioner måste deklareras innan koden som kallar på dem, så därför bör dessa ligga
högt (högst) upp i scriptet.

Best practice när man mamnger funktioner är att följa powershells verb-substantiv namnkonvention.
Exempel Get-ADUser, Remove-ADUser, Get-NetFirewallRule

Det går även att ange ett defaultvärde på ett argument (om användaren inte skickar med något)
#>

Function Get-Coffee ($Strength = "Strong", [Boolean]$Milk = $false)
{
    Process
        {
        Write-host $Strength "Coffee, Milk:" $Milk -ForegroundColor Green
        }
}

#Här kallar vi på Get-Coffee utan argument och accepterar defaultkaffe

Get-Coffee

# Man kan även göra argumenten Mandatory för att Powershell ska fråga om argumentet om det saknas.

Function Get-Coffee
{
    Param 
        (    
        [parameter(Mandatory=$true)]$Strength,
        [parameter(Mandatory=$False)][Boolean]$Milk = $False    
        )

    Process
        {
        Write-host $Strength "Coffee, Milk:" $Milk -ForegroundColor Green
        }
}

Get-Coffee

<# Det finns även ett gäng andra valideringsattribut för argument

AllowNull
AllowEmptyString
ValidateCount (specifies the minimum and maximum number of parameter values)
ValidateLength (specifies the minimum and maximum number of characters in a parameter)
ValidatePattern (specifies a regular expression that is compared to the parameter)

[parameter(Mandatory=$false, ValueFromPipeline=$true)][Boolean]$Milk

Det går även att läsa ut argumenten ur $Args, eller att bestämma positioner för argument.
Eller läsa direkt från en pipeline i $input

En bra referens för funktioner i Powershell

https://4sysops.com/archives/the-powershell-function-parameters-data-types-return-values/

Men nu tar vi kaffe!

#>
