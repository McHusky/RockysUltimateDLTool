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
$driverDataLoad = New-Object OpenQA.Selenium.Edge.EdgeDriver("$dataPath",$options)
#cls

#Open URL
$driverDataLoad.Url = "https://www.data-load.in/login/login"

#$ErrorActionPreference = 'SilentlyContinue'
#$driverDataLoad.FindElement([OpenQA.Selenium.By]::Id('navbar_username')).SendKeys('Rockschuppen')

#Login to data-load

$driverDataLoad.FindElements([OpenQA.Selenium.By]::XPath('//*[@name="login"]')).SendKeys("$userDataLoad")
$driverDataLoad.FindElements([OpenQA.Selenium.By]::XPath('//*[@name="password"]')).SendKeys("$passDataLoad")

$driverDataLoad.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="top"]/div[4]/div/div[2]/div[2]/div/div/form/div[1]/div/dl[3]/dd/ul/li/label/i')).Click()

$driverDataLoad.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="top"]/div[4]/div/div[2]/div[2]/div/div/form/div[1]/dl/dd/div/div[2]/button/span')).Click()

#Search $rls
$driverDataLoad.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="top"]/div[4]/div/div[2]/div[3]/div/form/div/div/div/input')).SendKeys("$rlsSearch")
$driverDataLoad.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="top"]/div[4]/div/div[2]/div[3]/div/form/div/div/div/input')).Submit()


#If download found, catch link
$currentURL = $driverDataLoad.Url

if($currentURL -match '\d'){
   Write-Host "Data-Load DL gefunden!"

   #Open thread
   $rls2 = $rlsSearch -replace '"', ''
   ($driverDataLoad.FindElements([OpenQA.Selenium.By]::XPath('//a[@href]')) | Where {$_.Text -eq "$rls2"}).Click()

   $global:dataLoadLink = $driverDataLoad.Url
}

#Close Driver
$driverDataLoad.Close()

#Quit Driver
$driverDataLoad.Quit()