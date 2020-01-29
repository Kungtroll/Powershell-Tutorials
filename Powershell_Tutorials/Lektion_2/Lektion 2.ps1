<# 

Recap from session 1:

Datypes: Int, string, boolean, single, datetime, xml, array, hashtable

Objects - Methods & Properties:
$objectname.methodname
$objectname.propertyname
$objectname.gettype()
$objectname | get-member

String management
ForEach

#>

$Numbers = @(1,2,3,4,5,6,7,8,9,0)
write-host "Element 0 is" $Numbers[0] -ForegroundColor Green

# The simplest way of looping through the array is to use a 
# simple ForEach

ForEach ($number in $numbers)
    {
    write-host $number -ForegroundColor Green
    }


# In the pipeline
$Numbers | %($_){write-host $_ -ForegroundColor Green}
# '%' is an alias of 'ForEach-Object'. Alias can introduce possible
# problems and make scripts hard to maintain. Please consider 
# changing alias to its full content.

#So without the % alias
$Numbers | ForEach-Object ($_){write-host $_ -ForegroundColor Green}
# ForEach-Object is a cmdlet with a bunch of parameters that 
# offers more functionality than ForEach.
# Foreach is also an alias for Foreach-Object, meaning that
# these two is easily confused. A way of telling is that 
# ForEach is followed by the ""$itemvariable in $datasetvariable)"
# Examples:
# ForEach ($item in $items) {Do something}
# ForEach($stone in $bucket) {"Throw away stone"}

#This one is actually when you use the alias for ForEach-Object
$Numbers |ForEach {write-host $_ -ForegroundColor Green}
# Visual Studio code remarks a problem here:
# 'ForEach' is an alias of 'ForEach-Object'. 
# Alias can introduce possible problems and make scripts hard
# to maintain. Please consider changing alias to its full content.


# You can also use the foreach method on the array-object
# This was introduced in POSH V4 and is supposed to be 
# considerably faster when working with large datasets.
$Numbers.ForEach({write-host $_ -ForegroundColor Green})

<#

Export-csv / Import-csv
Select-Object -Expandproperty

#>




<#
Session 2

Walkthrough of the exercise from session 1
If, ElseIf, Else
Switch
Do..While
Read-Host
Write-Host

Exercise until next session

(Functions)
#>

$Number = Read-Host "Enter a number"

If ($Number -lt 10) 
    {
    Write-Host "The number is less than 10"
    }
    ElseIf ($Number -eq 10)
    {
    Write-Host "The number is 10"
    }
    Else
    {
    Write-Host "The number is greater than 10"
    }

#Switch

Switch (Read-Host "Enter a number between 1-5")
    {
       1 {Write-Host "The number is 1"}
    
       2 {Write-Host "The number is 2"}

       3 {Write-Host "The number is 3"}

       4 {Write-Host "The number is 4"}

       5 {Write-Host "The number is 5"}
       default 
       {
       Write-Host "The number is not within 1-5" ;Break
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

#Or a do-while with an if-else inside

$Sant = $False
Do 

{
    $Answer = Read-Host "What is the capital of Mexico?"
    If ($Answer -eq "Mexico City") 
        {
        $Sant = $True
        write-Host "Correct!"
        }
    Else 
        {
        $Sant = $False
        write-host "Wrong answer, please try again!"
        }
}

While ($Sant -ne $True)

# Functions
# A function is basically the same thing as a method of an object
# The function can receive input parameters and return information
# Functions limits the "scope" of variables, a variable used in a 
# function is not available outside the function.
# This is just a brief introduction to functions, there is a lot
# more to know about functions.
Function WriteMyName ($name)
    {
        $Greeting = "Hello " + $Name
        Return $Greeting
    }

$Myname = read-host "Please enter your name..."
write-host -ForegroundColor Green (WriteMyName $Myname)