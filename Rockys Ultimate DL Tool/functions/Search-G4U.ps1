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
$driverG4U = New-Object OpenQA.Selenium.Edge.EdgeDriver("$dataPath",$options)
#cls

#Open URL
$driverG4U.Url = "https://g4u.to/"

$driverG4U.FindElement([OpenQA.Selenium.By]::XPath('//*[@name="searchItem"]')).SendKeys("$rlsSearch")
$driverG4U.FindElement([OpenQA.Selenium.By]::XPath('//*[@name="searchItem"]')).Submit()

$found = $null

$ErrorActionPreference = 'SilentlyContinue'
$found = $driverG4U.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[3]/div[4]/div[2]/a')).getAttribute("href")

$ErrorActionPreference = 'Continue'

#If download found, catch link
if($found -ne $null){
   Write-Host "G4U DL gefunden!"

   $global:g4uLink = $found
}else{
   Write-Host "Kein Download bei G4U gefunden"
}

#Close Driver
$driverG4U.Close()

#Quit Driver
$driverG4U.Quit()