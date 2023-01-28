$showProcesses = $false

$check_all_functions =
@"
Get-Passwords.ps1
Get-ToolUpdate.ps1
Search-ByteTo.ps1
Search-DDLWarez.ps1
Search-DataLoad.ps1
Search-HDSource.ps1
Search-MovieBlogArea.ps1
Search-StarWarez.ps1
Search-VideothekCX.ps1
Update-EdgeDriver.ps1
Search-Gload.ps1
Search-G4U.ps1
"@ -split "`n"

$showConsole = 0
if ($showProcesses -eq $true){$showConsole = 1}

# Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
$null = [Console.Window]::ShowWindow($consolePtr, $showConsole) 

$rawGithub = "https://raw.githubusercontent.com/McHusky/RockysUltimateDLTool/main/Rockys%20Ultimate%20DL%20Tool"

$root = ([IO.FileInfo] $MyInvocation.MyCommand.Path).Directory.Parent.FullName

### PART 1 - File Availability ###

$rawGithubFunctions = "$rawGithub/functions"

$functionsPath = "$root\functions"

foreach($function in $check_all_functions){
   $localPath = "$functionsPath\$function"

   if((Test-Path -Path "$localPath" -PathType Leaf) -eq $false){
      Write-Host "$function"
      Invoke-Webrequest -Uri "$rawGithubFunctions/$function" -Outfile "$localPath"
   }
}


### PART 2 - File Update ###

<# OBSOLET - ONLY WORKING OUTSIDE OF SCRIPT
$exclude =
@"
logins.txt
data
Get-ToolUpdate.ps1
"@ -split "`n"
$toolFiles = (Get-ChildItem -Path $root -Exclude $exclude | Get-ChildItem -File -Recurse).FullName
#>

$toolFiles = (Get-ChildItem -Path "$root" -File -Recurse).FullName

foreach ($file in $toolFiles)
{
   if($file -match "\\data\\" -OR $file -match "logins.txt"){}else{
      $fileName = $file | Split-Path -Leaf
      $toolFilesSubpath = $file.Replace("$root","")
      $toolFilesURLs = ("$rawGithub"+"$toolFilesSubpath").Replace("\","/")

      $contentA = Get-Content $file -Encoding utf8
      $contentB = Invoke-RestMethod "$toolFilesURLs"

      if (Compare-Object -ReferenceObject $contentA -DifferenceObject ($contentB -replace '\r?\n\z' -split '\r?\n')){
         Write-Host "`n$([char]0x2715) $fileName`n"
         Invoke-Webrequest -Uri "$toolFilesURLs" -Outfile "$file"
      }else{
         Write-Host "$([char]0x2713) $fileName"
      }
   }
}