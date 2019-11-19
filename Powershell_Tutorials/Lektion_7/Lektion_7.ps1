<#
Working with Runbooks in SMA & Azure Automation. 
Workflows
Parallellisering
Checkpoints

InlineScript

Visual Studio Code + Addons
GIT, GitHub, GitLab, Team Foundation Server, Azure Devops m.m.
#>

# SMA & Azure Automation
# Workflow <> Inlinescript

<# Workflows körs i Windows Workflow Foundation
 Namnet på Workflow ska vara samma som PS1-filen och följa std. namnkonvention för PS.
 Activities istället för cmlets.
 Det finns vissa integration modules som går att importera till Automation (SMA/Azure). 
 T.ex. SCOM eller Azure moduler.

 För att köra cmdlets behöver man använda InlineScript
 Men då går det inte att använda vissa features som Activities har, men det går även att importera moduler med
 New-SmaPortableModule
#>

<# Parallell exekvering gör att flera saker kan göras samtidigt utan att aktiviterna behöver vänta på varandra.
 I Parallell eller Sequence kan inte workflow variabler ändras per default, men de kan läsas.
 För att ändra en Workflow variabel sätter man scope till $Workflow.
 $Variabel = 1
 Parallel 
    {
    write-host $Variabel
    Ger outputten 1
    $Workflow:$Variabel = 2
    }
Write-Host $Variabel
Ger nu 2

För att returnera värden till "parent" scope får man helt enkelt returnera till variabler
$TFromSequence = Parallel
    {
        Sequence
        {
            #To export variable values from 
            # parallel/sequence, return the value.
            $t = 3
            $t   
        }        
    }   
    "T = $TFromSequence"


#>
Parallell
{
  <Activity1>
  <Activity2>

  Sequence
  {
   <Activity3>
   <Activity4>
  }
}
<Activity5>

ForEach -Parallel ($<item> in $<collection>)
{
  <Activity1>
  <Activity2>

    Sequence
    {
        <Activity3>
        <Activity4>
    }
}
<Activity5>

<# Checkpoints

Alla variabler och output sparas ner i Automation-databasen (en snapshot) med
Checkpoint-Workflow
För att kunna återuppta runbook igen om RBn av någon anledning hamnar i suspended (koden kanske har stoppat 
då något kommando inte kunde köra efterssom en annan tjänst var nere för stunden).
Denna snapshot försvinner när runbooken kört klart.

Inifrån ett Workflow kan man skapa en checkpoint och sätta RBn i suspend med.
Suspend-Workflow 

Utifrån kan man sätta en runbook i suspend med cmdlet.
Suspend-Job

Det går att återuppta med cmdlet.
Resume-Job

Get-Job cmdlet hämtar workflow job. 
Receive-Job cmdlet läser ut output från ett job.
#>

<# InlineScript
 Används för att köra cmdlets och annat som inte går att köra i ett workflow, 
 inklusive kommandon på andra maskiner utanför Windows Workflow Automation.
 Undvik det om möjligt i runbooks.
 Det finns inte stöd för checkpoints i ett InlineScript block.
 Ett InlineScript blockerar hela powershell sessionen tills hela scriptblocket är kört.
 Aktivitetersom Get-AutomationVariable och  Get-AutomationPSCredential är inte tillgängliga
 i ett InlineScript block.

 Försök att minimera vad som körs i en Inline-block, t.ex. så kan du köra en ForEach i Workflow
 och i den köra InlineScript för varje iteration. Då kan en checkpoint göras mellan varje iteration.

 Du kan använda ForEach "Parallel för att köra saker samtidigt.
 Variabler som satts utanför inlinescript kan användas med $Using, t.ex.
 $Namn är deklarerad i workflow, i InlineScript nås denna med $using:Namn.
 För att returnera värden från ett InlineScript, använd en variabel som samlar allt från output stream.
 $Namn = InlineScript { Write-Output "server1" }
 Om du ändrar en variabel från workflow scope i inline så kommer det inte ändras i workflowvariabeln, 
 returnera istället det nya värdet.
 $a = InlineScript {$a = $Using:a+1; $a}

 Kör inte workflows inuti en InlineScript, även om det kan tyckas fungera så är det inget som MS testat.
#>

#Deklareras så här:

InlineScript
    {
     #Skriv kod här
    }



    <#
Select-object
Where-object

ErrorAction, WarningAction, InformationAction
ErrorVariable, WarningVariable, InformationVariable

Write-debug

write-error
Write-Verbose
write-output
ErrorAction
Write-Default
#...


Param
{}

Begin

{}
Process 

{} 

End {}
#>
