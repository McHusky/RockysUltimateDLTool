@ECHO OFF

Pushd "%~dp0"
powershell -executionpolicy bypass -file functions\main.ps1
popd

exit