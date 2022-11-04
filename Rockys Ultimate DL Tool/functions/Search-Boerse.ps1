$rlsSearch = "`"$rls`""
$rlsSearch = $rlsSearch.replace('.', ' ').replace('-', ' - ')

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
$driverBoerse = New-Object OpenQA.Selenium.Edge.EdgeDriver("$dataPath",$options)
#cls

#Open URL
$driverBoerse.Url = "https://boerse.am"

#$ErrorActionPreference = 'SilentlyContinue'
#$driverBoerse.FindElement([OpenQA.Selenium.By]::Id('navbar_username')).SendKeys('Rockschuppen')

#Login to boerse
$driverBoerse.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="navbar_username"]')).SendKeys("$userBoerse")
$driverBoerse.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="navbar_password"]')).SendKeys("$passBoerse")
$driverBoerse.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[2]/div/div/table/tbody/tr/td[1]/table[1]/tbody/tr/td/table/tbody/tr/td/form/table/tbody/tr[4]/td/input')).Click()

$driverBoerse.Url = "https://boerse.am/index.php"

#Search $rlsSearch
$driverBoerse.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="lsa_input"]')).Clear()
$driverBoerse.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="lsa_input"]')).SendKeys("$rlsSearch")
$driverBoerse.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="lsa_input"]')).Submit()

$currentURL = $driverBoerse.Url

if($currentURL -like "https://boerse.am/search.php?searchid=*"){
   Write-Host "Boerse DL gefunden!"

   #Open thread
   $rls2 = $rlsSearch -replace '"', ''
   ($driverBoerse.FindElements([OpenQA.Selenium.By]::XPath('//a[@href]')) | Where {$_.Text -eq "$rls2"}).Click()

   $global:boerseLink = $driverBoerse.Url
}

#Close Driver
$driverBoerse.Close()

#Quit Driver
$driverBoerse.Quit()