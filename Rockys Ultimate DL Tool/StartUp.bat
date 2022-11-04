@ECHO OFF

Pushd "%~dp0"
powershell -executionpolicy bypass -file functions\Get-ToolUpdate.ps1
powershell -executionpolicy bypass -file functions\main.ps1 -windowstyle hidden
popd

exit