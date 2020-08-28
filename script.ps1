Write-Host "running script.ps1 file from the extension"
New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"
New-Item -ItemType "file" -Path "c:\logfiles\extension_execution_test.txt"
Add-Content -Path "c:\logfiles\extension_execution_test.txt" -Value "the custom is running:" -Force
Get-Date | Add-Content C:\logfiles\extension_execution_test.txt