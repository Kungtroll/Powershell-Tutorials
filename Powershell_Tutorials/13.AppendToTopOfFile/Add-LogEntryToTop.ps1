<#
.SYNOPSIS
Writes a logentry to the top of a file.

.DESCRIPTION
Writes a logentry to the top of a file together witha a timestamp.

.PARAMETER Message
The logmessage to be written.

.PARAMETER Source
The source for this log message (application or host).
    
.PARAMETER Filepath
Specify a target logfile (full path).

.EXAMPLE
@("Message1","Message2","Message3","Message4") | .\Add-LogEntryToTop.ps1 -Source "localhost"
Writes an array of messages coming from localhost to the default logfile in descending order.

.EXAMPLE
.\Add-LogEntryToTop.ps1 -Message "New entry" -Source "localhost" -Filepath ".\log2.txt"
Writes a single message coming from localhost to the top of logfile .\log2.txt.

.EXAMPLE
.\Add-LogEntryToTop.ps1 "New entry" "localhost" ".\log2.txt"
Writes a single message coming from localhost to the top of logfile .\log2.txt.



.OUTPUTS

.NOTES
Author: Peter Östman
History:	v1.0 Created script - 2019-12-09

#>

[CmdletBinding()]
param (
    
    [Parameter(
                Mandatory = $True, 
                ValueFromPipeline = $True,
                Position = 0
                )]
    [string] $Message,

    [Parameter(
                Mandatory = $True,
                Position = 1
                )]
    [String]$Source,

    [Parameter(
                Mandatory = $false,
                Position = 2
                )]
    [String]$Filepath = ".\logfile.txt"
) #Param

Begin {
    Try {
        Get-Content -Path $Filepath -ErrorAction Stop | Out-Null
    }
    Catch {
        New-Item -Path $Filepath -ItemType File
    }#Try
    $LogEntries = @()
}#Begin

Process {
    $LogEntry = (Get-Date -Format 'yyyy/MM/dd hh:mm:ss:ffff') + " " + $Source + " " + $Message
    $LogEntries += $LogEntry
} #Process

End{
    $LogContent = Get-Content -Path $FilePath
    $LogEntries = @($LogEntries|Sort-Object -Descending) 
    $LogEntries + $LogContent | Set-Content -Path $Filepath
} #End