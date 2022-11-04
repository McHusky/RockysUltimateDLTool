$edgeVersion = (Get-AppxPackage -Name "Microsoft.MicrosoftEdge.Stable").Version
$edgeVersionTXTPath = "$dataPath\edgeVersion.txt"
$edgeVersionTXT = Get-Content "$edgeVersionTXTPath"

$edgeDriverArchive = "edgedriver_win64.zip"

if($edgeVersion -ne $edgeVersionTXT){
   
   #Download EdgeDriver
   Start-BitsTransfer -Source "https://msedgedriver.azureedge.net/$edgeVersion/edgedriver_win64.zip" -Destination "$dataPath\$edgeDriverArchive"

   #Unzip archive
   Expand-Archive -Path "$dataPath\$edgeDriverArchive" -DestinationPath "$dataPath" -Force

   #Remove unnecessary stuff
   Remove-Item -Recurse -Force "$dataPath\Driver_Notes"
   Remove-Item -Force "$dataPath\$edgeDriverArchive"

   Set-Content $edgeVersionTXTPath $edgeVersion
}