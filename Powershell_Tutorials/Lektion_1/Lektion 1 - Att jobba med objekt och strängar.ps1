# Powershell - Skal, scriptspråk och scriptmotor

# Variabler

# Värdetyper

$Heltal = 11333333
$Heltal.GetType()

$Flyttal = 1.11
$Flyttal.GetType()

$Enabled = $true
$Enabled.GetType()

$Datum = Get-Date
$Datum.GetType()

<#
[string]    Fixed-length string of Unicode characters
 [char]      A Unicode 16-bit character
 [byte]      An 8-bit unsigned character

 [int]       32-bit signed integer (10 siffror heltal )
 [long]      64-bit signed integer
 [bool]      Boolean True/False value

 [decimal]   A 128-bit decimal value
 [single]    Single-precision 32-bit floating point number
 [double]    Double-precision 64-bit floating point number
 [DateTime]  Date and Time

 [xml]       Xml object
 [array]     An array of values
 [hashtable] Hashtable object
  #>
  
<#
    - Objekt
    - Methods & Properties
    För att se methods & Properties kör man en pipe | till Get-Member
    För att använda en metod eller en property använder man punkt och sedan den property eller metod man vill jobba med - $object.property, $object.method
#>

#String
$Namn = "Kalle Anka"

# Vad är det här för ett objekt?

$Namn | Get-Member

#Eller alias

$Namn | gm


# Samma sak med ett objekt från ett Powershell cmdlet.
Get-ADUser "MyUserName" | Get-Member
(GET-ADuser "MyUserName").SID
$user = Get-ADUser "MyUserName"
$user.SID

# Använda en metod, testar .Equals

$user2 = get-aduser "MyUserName"
$user.Equals($user2)

# Samma sak, fast vi testar en metod på en property
# Vilka metoder och Properties har GivenName?
$user.GivenName | Get-Member

# Nu vill jag testa att använda metoden .Equals på $User.GivenName för att se om det är samma som $User2.GivenName
$user.GivenName.Equals($user2.GivenName)


# Strängar
# Skapa en sträng
$Namn = "Kalle, Anka"

#Dela upp den i två strängar
#Hitta kommatecknet
$GivenName = $Namn.Split(",")

# Vad blev $GivenName för typ av objekt?
$GivenName.GetType()
# För att titta på varje element ("rad") i en array kan man använda [elementnummer], den första är alltid 0
write-host $GivenName[0] -ForegroundColor Green
write-host $GivenName[1] -ForegroundColor Green

$Numbers = @(1,2,3,4,5,6,7,8,9,0)
write-host "Element 0 är" $Numbers[0] -ForegroundColor Green

# ForEach, för att jobba med alla ellement i en array

Foreach ($number in $numbers)
    {
    write-host $number -ForegroundColor Green
    }

# I pipeline kan man kan även skriva

$Numbers | %($_){write-host $_ -ForegroundColor Green}



$Users = Get-ADUser -Filter{name -like "pxs*"}

# Exportera objekt från en array till en fil, till exempel csv-fil med export-csv
$Users | Export-Csv -Delimiter ";" -Path '.\Documents\Scripts\Lektion 1\users.csv' -NoTypeInformation

# Välj ut de fälten vi vill ha istället med select-object, använd ; som delimeter för att det ska lira bra med Excel
$Users | select-object GivenName, Surname, Name, Enabled | Export-Csv -Path '.\Documents\Scripts\Lektion 1\users.csv' -NoTypeInformation -Delimiter ";" -Encoding UTF8

$Users.Count
#Självfallet går det också att läsa in information till objekt med cmdlets som import-csv, import-xml

$ImportedUsers = Import-Csv -LiteralPath '.\Documents\Scripts\Lektion 1\users.csv'-Delimiter ";" -Encoding UTF8

$ImportedUsers | Format-List
