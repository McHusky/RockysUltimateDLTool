$rlsSearch = $rls.ToLower().Replace('.', '-')
$ddlWarez = 'https://ddl-warez.cc/video/stream/' + $rlsSearch + '/'
	
$ErrorActionPreference = "SilentlyContinue"
$dlDDLWarez = $null
	
#Search for a working HDSource page
$dlDDLWarez = Invoke-WebRequest -Uri "$ddlWarez"
$ErrorActionPreference = "Continue"
	
if ($dlDDLWarez -eq $null)
{
	Write-Host "Kein Download bei DDL-Warez gefunden"
}
else
{
	$global:ddlWarezLink = $ddlWarez
	Write-Host "DDL-Warez DL gefunden!"
	#Start-Process $ddlWarez
}