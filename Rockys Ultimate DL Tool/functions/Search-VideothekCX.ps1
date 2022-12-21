$rlsSearch = $rls

#Import Selenium Driver
Import-Module "$dataPath\WebDriver.dll"

#Set options
$options = New-Object OpenQA.Selenium.Edge.EdgeOptions
$options.addArguments('ignore-certificate-errors')
if($browserHidden -eq $true){
   $options.addArguments('--headless')
}
$options.AcceptInsecureCertificates = $True

#Load EdgeDriver
$driverVideothek = New-Object OpenQA.Selenium.Edge.EdgeDriver("$dataPath",$options)
#cls

#Open URL
$driverVideothek.Url = "https://videothek.cx/search.html?search_query=$rlsSearch"

$found = $null

$ErrorActionPreference = 'SilentlyContinue'
$found = $driverVideothek.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div/div/div[5]/div[5]/div[4]/a')).getAttribute("href")
$ErrorActionPreference = 'Continue'

#If download found, catch link
if($found -ne $null){
   Write-Host "Videothek.cx DL gefunden!"

   $global:videoThekCXLink = $found
}else{
   Write-Host "Kein Download bei Videothek.cx gefunden"
}

#Close Driver
$driverVideothek.Close()

#Quit Driver
$driverVideothek.Quit()