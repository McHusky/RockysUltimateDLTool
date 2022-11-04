$rlsSearch = $rls.ToLower().Replace('.', '-')
$movieBlogArea = 'https://movieblogarea.com/' + $rlsSearch + '/'
	
$ErrorActionPreference = "SilentlyContinue"
$dlMovieBlogArea = $null
	
#Search for a working Movie Blog Area page
$dlMovieBlogArea = Invoke-WebRequest -Uri "$movieBlogArea"
$ErrorActionPreference = "Continue"
	
if ($dlMovieBlogArea -eq $null)
{
	Write-Host "Kein Download bei Movie Blog Area gefunden"
}
else
{
	$global:movieBlogAreaLink = $movieBlogArea
	Write-Host "Movie Blog Area DL gefunden!"
	#Start-Process $movieBlogArea
}