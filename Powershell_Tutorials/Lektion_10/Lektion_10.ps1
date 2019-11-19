Measure-Command {.\Test-ConnectionRSPoolToFile.ps1}
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1 -DoItFast}
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1 -DoItFast -MaxThreads 10 -FilePath = "C:\temp\10Threads.txt"}
Measure-Command {.\Test-ConnectionRSPoolToFile.ps1 -DoItFast -MaxThreads 25 -FilePath = "C:\temp\25Threads.txt"}
