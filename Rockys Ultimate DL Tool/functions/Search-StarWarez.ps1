<#
$rlsSearch = $rls.ToLower().Replace('.', '-')
$starWarez = 'https://starwarez.to/movies/' + $rlsSearch + '/'
	
$ErrorActionPreference = "SilentlyContinue"
$dlStarWarez = $null
	
#Search for a working HDSource page
$dlStarWarez = Invoke-WebRequest -Uri "$starWarez"
$ErrorActionPreference = "Continue"
	
if ($dlStarWarez -eq $null)
{
	Write-Host "Kein Download bei Star-Warez gefunden"
}
else
{
	$global:starWarezLink = $starWarez
	Write-Host "Star-Warez DL gefunden!"
	#Start-Process $starWarez
}
#>