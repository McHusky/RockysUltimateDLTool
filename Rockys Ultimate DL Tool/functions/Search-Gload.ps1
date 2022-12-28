$rlsSearch = $rls.ToLower().Replace('.', '-')
$rlsSearch2 = $rls.Replace('_', ' ')
$gLoad = 'https://gload.to/' + $rlsSearch

$ErrorActionPreference = "SilentlyContinue"
$dlGload = $null

#Search for a working Gload page
$dlGload = Invoke-WebRequest -Uri "$gLoad"
$ErrorActionPreference = "Continue"

$pageTitle = $dlGload.ParsedHtml.title

if (($pageTitle -ne $rls) -AND ($pageTitle -ne $rlsSearch2))
{
	Write-Host "Kein Download bei GLOAD gefunden"
}else{
	$global:gloadLink = $gLoad
	Write-Host "GLOAD DL gefunden!"
	#Start-Process $gLoad
}