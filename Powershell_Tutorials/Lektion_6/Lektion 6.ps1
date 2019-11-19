<#
Working with Credentials object.


Invoke-Command
Enter PSSession
Exit PSSession
Get-PSSession
Remove-PSSession

Enable Powershell Remoting
Configure TrustedHosts
Restart WinRM Service

GIT
#>

#Enable PSRemoting on a host (Starts WinRM on ports TCP/5985 = HTTP, TCP/5986 = HTTPS)
Enable-PSRemoting -Force

#Configure TrustedHosts 
#winrm set winrm/config/client '@{TrustedHosts="192.168.01,"}@'
#The restart WinRM
#Restart-Service WinRM

#Test the connection
Test-WSMan -ComputerName "Computername"

$credentials = Get-Credential

$Computers = @('Server1';'Server2')

Invoke-Command -ComputerName "Server1" -Credential $credentials -ScriptBlock {Get-Process}
Invoke-Command -ComputerName $Computers -FilePath C:\Users\MyUser\Documents\Example.ps1 -ArgumentList svchost

<#Med en persistent connection för att kunna köra kommandon flera gånger utan att logga in återkommande. 
Notera att Variabler också finns kvar i sessionen för fortsatt användning.#>

$session = New-PSSession -ComputerName $Computers -Credential $credentials
Invoke-Command -Session $session -ScriptBlock {$a = Get-Culture}
Invoke-Command -Session $session -ScriptBlock {
    write-host $env:COMPUTERNAME -ForegroundColor Green
    write-host $a.DisplayName -ForegroundColor Green
    }

#Sessionerna ligger nu öppna, du kan lista dem och gå tillbaka in i dem.
Get-PSSession

#Enter-PSSession gör att du kan skriva kommandon direkt i skalet som om du satt på den maskinen (du är i en remote Powershellsession tills du kör Exit-PSSession)
#$Computer = Read-Host "Enter computername"
$Computer = 'Server1'
$Minsession = (Get-PSSession)[0]
Enter-PSSession $Minsession
Exit-PSSession

#Du hade även kunnat köra Enter-PsSession -Id 'sessionsnummer'

#Eller om du vill skapa en helt ny session
$session = New-PSSession -ComputerName $Computer -Credential $credentials
Enter-PSSession -Session $session

#I sessionen kan du köra samma kod som vi gjorde ovan.
$a = Get-Culture
write-host $env:COMPUTERNAME -ForegroundColor Green
write-host $a.DisplayName -ForegroundColor Green

Exit-PSSession

#För att döda en session använder du Remove-PSSession
Remove-PSSession $Minsession

#Går också att döda en specifik session med -Id argumentet precis som i Enter-PSsession

#Eller så kan du använda pipeline
Get-PSSession | Remove-PSSession

<#Objekten du får tillbaka med Invoke-Command är "deserialized", vilket innebär att de inte längre är av samma klass utan nya 
objekt som saknar de metoder som finns i orginalklassen. Det beror på att när objekten skickas över till din dator så omvandlas de
till xml objekt, vilket inte är helt ologiskt då objekten egentligen bara är definierade på hosten du upprättat en session emot.
Dessutom får outputen en till property som heter .PSComputerName, vilket är ett bra sätt att hålla reda på vilken host som 
rapporterat vad i ett större jobb. Vill man använda metoderna måste man alltså göra det i sessionen på den host man kör remoting 
mot.

#>

Get-Process | Get-Member
#TypeName: System.Diagnostics.Process

Invoke-Command -ComputerName Server1 -Credential $credentials -ScriptBlock {Get-Process} | Get-Member
#Deserialized.System.Diagnostics.Process

<#
Enable Powershell Remoting
Configure TrustedHosts
Restart WinRM Service
#>
