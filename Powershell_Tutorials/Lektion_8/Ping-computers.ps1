[CmdletBinding()]
param (
    [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
    [PSCustomObject[]]
    $Computer,

    [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
    [String]
    $Username
)

Begin {
    $modules = @('Microsoft.PowerShell.Management','min.egna.som.inte.finns')
    ForEach ($module in $modules) {
        If(!(get-module $module))
        {
            Try {
                Import-Module $module -ErrorAction Stop
                get-module $module
            }
            Catch {
                Write-host -ForegroundColor Red "The required module $module is missing and could not be loaded." -ErrorAction Continue
            }
        }
    }
}
Process {
    
    #Here is how try-catch will behave with the test-connection cmdlet. Note that one ping generates an error and brings us into the catch.
    [Int32]$Failed = 0
    Write-host -ForegroundColor Yellow "First using try-catch"
    do {
        try {
            test-connection $Computer.name -ErrorAction Stop | Out-Null
            Write-host -ForegroundColor Green "Hello $Username, $($Computer.name) is responding in domain $($Computer.domain)"
            $Connectable = $True
        }
        catch {
            $Failed ++
            $Connectable = $false
            If($Failed -ge 4) {
                Write-host -ForegroundColor Red "Hello $Username, $($Computer.name) is not responding in domain $($Computer.domain)"}
        }    
    } until ($Failed -ge 4 -or $Connectable)
    
    #Since i'm not interrested in the output from test-connection, just the final result I'll use if instead
    Write-host '---'
    Write-host -ForegroundColor Yellow "Now trying with If-Else and ErrorAction -Ignore"

    If ((test-connection $Computer.name -Quiet) -eq "True") {
        Write-host -ForegroundColor Green "Hello $Username, $($Computer.name) is responding in domain $($Computer.domain)"
    }
    else {
        Write-host -ForegroundColor Red "Hello $Username, $($Computer.name) is not responding in domain $($Computer.domain)"
    }
    Write-host '--------------------------------'
}
End {
    Write-host -ForegroundColor Yellow "All computers tested..."
}