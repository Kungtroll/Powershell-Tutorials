Break
#Running tasks in parallel in Powershell

#1. PSjobs - cmdlets from Microsoft.PowerShell.Core, included from PSVersion 3.
#
#Get-Command *-job
#CommandType     Name                                               Version    Source
#-----------     ----                                               -------    ------
#Cmdlet          Debug-Job                                          3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Get-Job                                            3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Receive-Job                                        3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Remove-Job                                         3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Resume-Job                                         3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Start-Job                                          3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Stop-Job                                           3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Suspend-Job                                        3.0.0.0    Microsoft.PowerShell.Core
#Cmdlet          Wait-Job                                           3.0.0.0    Microsoft.PowerShell.Core
#
$job = start-job {write-output "Hello World"}
#List jobs
Get-Job
#Get job with ID 1
Get-job -id 1
#Get the job I started above
Get-job $job
#Get job output by using Receive-job (Use the -Keep switch to keep the output in the job (otherwise it's cleared)
Receive-Job $job
#OR
# Refer to the job Id or Name
Receive-Job -id 1 -Keep
# Use the -Asjob parameter on some commands
$Job = Invoke-command {write-output "Hello World"} -AsJob1

#2. Use runspaces to increase performance.
$Runspace = [runspacefactory]::CreateRunspace()
$PowerShell = [powershell]::Create()
$PowerShell.Runspace = $Runspace
$Runspace.Open()
$PowerShell.AddScript({[pscustomobject]@{
    Output = 'Hello World!'
}})
$Job = $PowerShell.BeginInvoke()
$PowerShell.EndInvoke($job)
$PowerShell.Dispose()

#3. New feature in Powershell 7: ForEach-Object -Parallel 

#4. Use Powershell Workflows to do ForEach -Parallel
Workflow Write-Parallel{
    $numbers =@(1..10)
    ForEach -parallel ($number in $numbers)  {
        Write-Output "Hello $number World!"
    }
}
Write-Parallel

#5. Install a module called PoshRSJob (Easy-mode runspaces)

#6. Use .Net (again) to create a runspacepool.
Set-Location C:\Git\Win_Servers\Powershell_Tutorials\Lektion_10
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1}
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1 -DoItFast}
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1 -DoItFast -MaxThreads 10 -Path "C:\temp\10Threads"}
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1 -DoItFast -MaxThreads 20 -Path "C:\temp\20Threads"}


# Multithreading challenges:
# It's a set and forget process, you cannot interact with the runspace once it's started, you can only provice it with startup parameters.
# Variables are only available inside the runspace.
# Output is also tricky, basically no output on screen. Having several threads logging to the same file will cause locks. (a database could probably be useful)
# Whatever you want to run in parallel must be designed for running in multiple-threads - thread-safe code
#
