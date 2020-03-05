Param(
    [Switch]$DoItFast,
    $MaxThreads = 5,
    $FilePath = "C:\temp\PingResult.txt"
    )

$Servers =@(
    'Server1',
    'Server2',
    'Server3',
    'Server4',
    'Server5',
    'Server6',
    'Server7',
    'Server8',
    'Server9',
    'Server10',
    'Server11',
    'Server12',
    'Server13',
    'Server14',
    'Server15',
    'Server16',
    'Server17',
    'Server18',
    'Server19',
    'Server20',
    'Server21',
    'Server22',
    'Server23',
    'Server24',
    'Server25',
    'Server26',
    'Server27',
    'Server28',
    'Server29',
    'Server30',
    'Server31'
)#Array of Servers

#Check if the DoItFast Parameter is provided to run the jobs in parallell with RunspacePool, otherwise move to the Else Section to run sequencially
If ($DoItFast){
    $RunspacePool = [runspacefactory]::CreateRunspacePool(1, $MaxThreads)
    $RunspacePool.Open()
    $Jobs = @()

    $Servers | Foreach-Object {

        #This Section invokes a Powershell script in a runspacepool
        #Allowing each server to be pinged in it's own runspace / process thread
        #By using a runspacepool, we can ping as many servers simultaneoulsy as 
        #the maximum number of threads we allow. Increasing the number of threads
        #can reduce the time it takes to complete all the commands, however it will
        #consume more resources on the host running the script. 
        
        #Playing with maximum threads parameter can show where the sweet-spot is for 
        #the number of threads, there will be a spot where we get no more reduction 
        #in time to complete the commands. 
        #You can measure this with the measure-command cmdlet.

        $PowerShell = [powershell]::Create()
        $PowerShell.RunspacePool = $RunspacePool
        $ParamList = @{
            Server = $($_)
            FilePath = $FilePath
        }#ParamList
        
        $PowerShell.AddScript({
            Param ($Server,$FilePath)
            $OutObject =  [pscustomobject]@{
                ServerName = $Server
                Connectable = $false
            }#CustomObject

            try {
                Test-Connection $Server -ErrorAction Stop
                $OutObject.Connectable = $True
            }catch {
                $OutObject.Connectable = $False
            }#Try

            Out-File -InputObject $OutObject -Append -FilePath $FilePath

        }).AddParameters($ParamList)#AddScript
        
        $Jobs += $PowerShell.BeginInvoke()
    }#ForEachObject
    while ($Jobs.IsCompleted -contains $false) {Start-Sleep -Seconds 1}

    $RunspacePool.Close()
} #End If
else {
    $Servers |
    Foreach-Object {
        $Server = $_
        $OutObject =  [pscustomobject]@{
            ServerName = $_
            Connectable = $false
        }#CustomObject
        try {
            Test-Connection $Server -ErrorAction Stop
            $OutObject.Connectable = $True
        }
        catch {
            $OutObject.Connectable = $False
        }#Catch
        Out-File -InputObject $OutObject -Append -FilePath $FilePath
    }#Foreach-Object
}#End Else
