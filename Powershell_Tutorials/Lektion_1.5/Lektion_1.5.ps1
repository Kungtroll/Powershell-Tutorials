<#
Working with Powershell cmdlets, aliases and modules.
Using the Get-Help command
Powershell providers
#>

#If you haven't already figured it out the "#" in front
#of a word or line marks everything right of the # as
#comments, and Powershell will not read it as executable
#code/commands.
#With the 
<##>
#You can make commmentary text stretchin over multiple lines.

<#
Multiple 
line 
comments
#> #End of the comment section...

#Working with Powershell cmdlets.

Get-Command Get-Verb
#It's a powershell function, shipped with powershell.

Get-Command Get-ChildItem
#It's a command exported from the Microsoft.Powershell.Management module.

get-command gci
#It's an Alias for Get-ChildItem!

Get-Command Get-Date -Syntax

#If you want the information in a window
Show-Command Get-Date

#Alias

Get-Alias gci

#What more aliases are there?
Get-Alias

#I need a module for azure resource manager
Find-Module -Name *azurerm*
#I think I'll settle with the main AzureRM module
Find-Module -Name azurerm

#How do I install it?
Get-Command -Noun Module

#Install Module sounds fitting... I'll use the -WhatIf flag,
#just to see what the command would do...
Install-Module -Name AzureRM -WhatIf

#I need admin rights... What now? 
#I could either elevate this powershell session to my admin account, 
#or instead settle with just installing for this user...
Install-Module -Name AzureRM -Scope CurrentUser -WhatIf
#Could not find the module... Was it case sensitive?
Install-Module -Name azurerm -Scope CurrentUser -WhatIf

#But what if I use the object that Find-Module returned to get the name right? 
#Pipe the output from Find-Module to Install-Module
Find-module -Name azurerm | Install-Module -Scope CurrentUser -AllowClobber -WhatIf
#As a matter of fact, the azure modules are now being replaced by Az modules, 
#so no point in installing the old ones...

Get-Module ActiveDirectory
#Interresting, I can see the exportedcommands from this module...

#Let's explore the list of exportedcommands...
Get-Module ActiveDirectory | 
Select-Object -ExpandProperty exportedcommands

#I wonder if this module is of a legacy version? Let's update it!
Update-Module ActiveDirectory

#I guess I installed this module from the Windows RSAT package. 
#It's not from the windows powershell gallery and cannot be updated this way.

#What other modules do I have installed?
Get-Module

Get-Module ActiveDirectory | Remove-Module -WhatIf
#Look at the path of the module... Powershell will look for modules in all
#paths stored in a environment variable.
$env:PSModulePath
#If you can't use find-module | install-module to install modules from 
#Powershell Gallery you can put a module in one of these folders and 
#import it with the import-module command.
#Powershell will automatically look for the module in these paths.
import-module ActiveDirectory

#Using help
Get-Help
#shows how to use Get-help
Get-help Select-Object

#Getting help about the Get-Help cmdlet...
Get-help get-help

#Show just examples
Get-help -Examples

#I need the syntax...
Get-Command Get-help -Syntax

#There's an online Switch parameter, let's read more about what
#it's used for...
Get-help Get-Help -Parameter Online

#Let's look at the online help for Select-Object while we are at it
Get-help Select-Object -Online

#Let's try getting the detailed help for Select-Object without 
#looking at the online documentation
Get-help Select-Object -Detailed

#Maybe my help is outdated, let's update it
Update-Help
#Guess I need to be elevated to do that...

#Shows help about Alias
Get-Help About_Alias
#Shows all help topics ending with variables
Get-Help About_*variables
#Shows all help topics starting with Environ
Get-Help About_Environ*
#Interresting, I can see all the environment variables by typing:
Get-ChildItem Env:

#Powershell has a bunch of providers that expands the use of
#powershell, such as registry, filesystems, certificates and
#providers provided by third parties, such as VMware.

#Powershell Providers

#List all available providers
Get-PSProvider
#You can work with a provider just like it was a filesystem,
#moving into the structure, and reading/changing values...

#Here's a different way to show all aliases...
Set-Location Alias:
Get-ChildItem

Set-Location C:\

#Or simply look at what functions are exported to powershell 
#right now.
Get-Childitem Function:
#Let's see what's autostarting from registry...
Get-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
#What a bunch of junk!

#Explore variables provider
get-childitem Variable:
$MyNewVariable = "Just a new value"
get-childitem Variable: |Select-object -First 10

#I can also view and manipulate my certificate store
#Let's look at my personal certificates
Get-ChildItem Cert:\CurrentUser\My

#You can also import new certifates to Trusted root
#with Import-Certificate, I won't do that, but I
#have found it very useful when dealing with several
#machines that needs to trust a certificate















