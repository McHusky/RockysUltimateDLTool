$rlsSearch = $rls.ToLower().Replace('.', '-')
$hdSource = 'https://hd-source.to/filme/' + $rlsSearch + '/'
	
$ErrorActionPreference = "SilentlyContinue"
$dlHDSource = $null
	
#Search for a working HDSource page
$dlHDSource = Invoke-WebRequest -Uri "$hdSource"
$ErrorActionPreference = "Continue"
	
if ($dlHDSource -eq $null)
{
	Write-Host "Kein Download bei HD-Source gefunden"
}
else
{
	$global:hdSourceLink = $hdSource
	Write-Host "HD-Source DL gefunden!"
	#Start-Process $hdSource
}