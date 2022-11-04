$loginsFileName = "logins.txt"
$domainBoerse = "boerse.am"
$domainDataLoad = "data-load.in"

$passEncryptionCertificateName = "RockysDLTool_logins.txt"
$passwordFileBoerse = "$dataPath\SecLogins\boerse.txt"
$passwordFileDataLoad = "$dataPath\SecLogins\data-load.txt"


# Get user data for boerse
$userData = Get-Content "$root\$loginsFileName"
$global:userBoerse = (($userData | Select-String "$domainBoerse" -context 0, 2 | Out-String -Stream | Select-String -Pattern 'username').ToString().Replace(' ', '').Split(":"))[1]
$passBoerse = (($userData | Select-String "$domainBoerse" -context 0, 2 | Out-String -Stream | Select-String -Pattern 'password').ToString().Replace(' ', '').Split(":"))[1]

# if passwords in txt are plain, then encrypt
# --- boerse
if ($passBoerse -eq "")
{
	Write-Host "Error! Boerse Password not found." -ForegroundColor Red
}
elseif ($passBoerse -ne "encrypted")
{
	#encrypt
	$encryptionCert = Get-ChildItem "Cert:\CurrentUser\My\" | Where { $_.Subject -eq "CN=$passEncryptionCertificateName" }
	if ($encryptionCert -eq $null)
	{
		Write-Host "Certificate will be generated!"
		New-SelfSignedCertificate -DnsName "$passEncryptionCertificateName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsage KeyEncipherment, DataEncipherment, KeyAgreement -Type DocumentEncryptionCert
	}
	$passBoerse | Protect-CmsMessage -To "cn=$passEncryptionCertificateName" | Out-File "$passwordFileBoerse"
	
	$pwLine = ($userData | Select-String "$domainBoerse" -context 0, 2 | Select-Object -ExpandProperty LineNumber) + 2
	
	#search line to replace
	$newUserData = @()
	$userData | ForEach-Object {
		if ($_.ReadCount -eq $pwLine) { $newUserData += $_ -replace "$passBoerse", "encrypted" }
		else { $newUserData += $_ }
	}
	
	#write new data as password
	$newUserData | Set-Content "$root\$loginsFileName"
}
else
{
	#try decryption
	$encryptionCert = Get-ChildItem "Cert:\CurrentUser\My\" | Where { $_.Subject -eq "CN=$passEncryptionCertificateName" }
	if ($encryptionCert -eq $null)
	{
		Write-Host "Error! No certificate found." -ForegroundColor Red
	}
	elseif (!(Test-Path "$passwordFileBoerse"))
	{
		Write-Host "Error! Boerse Password file not found." -ForegroundColor Red
	}
	else
	{
		$global:passBoerse = Unprotect-CmsMessage -Path "$passwordFileBoerse"
	}
	
	#Get-ChildItem "Cert:\CurrentUser\My\" | Where {$_.Subject -eq "CN=$passEncryptionCertificateName"} | Remove-Item
}


# Get user data for data-load
$userData = Get-Content "$root\$loginsFileName"
$global:userDataLoad = (($userData | Select-String "$domainDataLoad" -context 0, 2 | Out-String -Stream | Select-String -Pattern 'username').ToString().Replace(' ', '').Split(":"))[1]
$passDataLoad = (($userData | Select-String "$domainDataLoad" -context 0, 2 | Out-String -Stream | Select-String -Pattern 'password').ToString().Replace(' ', '').Split(":"))[1]

# if passwords in txt are plain, then encrypt
# --- data-load
if ($passDataLoad -eq "")
{
	Write-Host "Error! Data-Load Password not found." -ForegroundColor Red
}
elseif ($passDataLoad -ne "encrypted")
{
	#encrypt
	$encryptionCert = Get-ChildItem "Cert:\CurrentUser\My\" | Where { $_.Subject -eq "CN=$passEncryptionCertificateName" }
	if ($encryptionCert -eq $null)
	{
		Write-Host "Certificate will be generated!"
		New-SelfSignedCertificate -DnsName "$passEncryptionCertificateName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsage KeyEncipherment, DataEncipherment, KeyAgreement -Type DocumentEncryptionCert
	}
	$passDataLoad | Protect-CmsMessage -To "cn=$passEncryptionCertificateName" | Out-File "$passwordFileDataLoad"
	
	$pwLine = ($userData | Select-String "$domainDataLoad" -context 0, 2 | Select-Object -ExpandProperty LineNumber) + 2
	
	#search line to replace
	$newUserData = @()
	$userData | ForEach-Object {
		if ($_.ReadCount -eq $pwLine) { $newUserData += $_ -replace "$passDataLoad", "encrypted" }
		else { $newUserData += $_ }
	}
	
	#write new data as password
	$newUserData | Set-Content "$root\$loginsFileName"
}
else
{
	#try decryption
	$encryptionCert = Get-ChildItem "Cert:\CurrentUser\My\" | Where { $_.Subject -eq "CN=$passEncryptionCertificateName" }
	if ($encryptionCert -eq $null)
	{
		Write-Host "Error! No certificate found." -ForegroundColor Red
	}
	elseif (!(Test-Path "$passwordFileDataLoad"))
	{
		Write-Host "Error! Data-Load Password file not found." -ForegroundColor Red
	}
	else
	{
		$global:passDataLoad = Unprotect-CmsMessage -Path "$passwordFileDataLoad"
	}
	
	#Get-ChildItem "Cert:\CurrentUser\My\" | Where {$_.Subject -eq "CN=$passEncryptionCertificateName"} | Remove-Item
}