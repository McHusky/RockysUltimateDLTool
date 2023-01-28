$rlsSearch = $rls.replace('.','+').replace('-','+-+')

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
$driverByteTo = New-Object OpenQA.Selenium.Edge.EdgeDriver("$dataPath",$options)
#cls

#Open URL
$driverByteTo.Url = "https://byte.to/?q=$rlsSearch"

$found = $null

$ErrorActionPreference = 'SilentlyContinue'
$found = $driverByteTo.FindElement([OpenQA.Selenium.By]::XPath('/html/body/center/center/table/tbody/tr[3]/td[3]/table/tbody/tr[2]/td/table/tbody/tr[2]/td[1]/p/a')).getAttribute("href")
$ErrorActionPreference = 'Continue'

#If download found, catch link
if($found -ne $null){
   Write-Host "Byte.to DL gefunden!"

   $global:byteToLink = $found
}else{
   Write-Host "Kein Download bei Byte.to gefunden"
}

#Close Driver
$driverByteTo.Close()

#Quit Driver
$driverByteTo.Quit()