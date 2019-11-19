
Write-Host "Fråga 1:"
Write-Host "Vad kallas en lottsedel som är täckt med ett ogenomskinligt skikt som man tar bort med t.ex. nageln för att se om man vunnit?"
Write-Host
Write-Host "Fråga 2:"
Write-Host "Denna indiska stad hade år 2001 inklusive förorter 18 414 288 innevånare. Staden bytte namn 1995."
Write-Host
Write-Host "Fråga 3:"
Write-Host "Stjärnbilden Karlavagnen är en del av denna stjärnbild"
Write-Host
Write-Host "Fråga 4:"
Write-Host "Tor är ju bland annat åskans gud, men vad kallas hans vapen, den stora hammaren, som bland annat skapar blixtar och muller?"

$Question = Read-Host "Vilken fråga vill du besvara?"

Switch ($Question)
    {
        1 {$Answer = "skraplott"}
        2 {$Answer = "mumbai"}
        3 {$Answer = "stora björnen"}
        4 {$Answer = "mjölner"}
        Default {Write-Host "Ingen fråga vald";Exit}
    }

$Count = 0
Do {

    $Input = (Read-Host "Vad är svaret på frågan?").ToLower()
    $Count ++
    If ($Input -eq $Answer)
        {
            Write-Host "Rätt Svar!" -ForegroundColor Green
            $Correct = $true
        }

        ElseIf ($Count -lt 3)

        {
            $Correct = $false
            Write-Host "Fel svar, försök igen!" -ForegroundColor Red
        }
        Else 
        {
            Write-Host "Fel svar igen, det rätt svaret är $Answer" -ForegroundColor Green
        }

        
    } 
    While ($Correct -ne $True -and $Count -lt 3)

