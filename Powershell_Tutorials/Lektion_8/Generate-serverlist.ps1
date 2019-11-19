$Computers = @()

Do {
    $Computer = New-Object -TypeName PSCustomObject
    $Computer | Add-Member -MemberType NoteProperty -Name 'Name' -Value (Read-Host "Enter computername")
    $Computer | Add-Member -MemberType NoteProperty -Name 'Domain' -Value (Read-Host "Enter domain")
    $Computers += $Computer

    If ((Read-host "Would you like to add another computer? (Y/N)").ToLower()-eq "y") {
        $Finished = $false
    } Else {$Finished = $true}
} Until ($Finished)
Return $Computers