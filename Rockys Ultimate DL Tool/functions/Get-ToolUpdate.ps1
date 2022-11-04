$showProcesses = $false

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
      $toolFilesSubpath = $file | foreach {$_.Replace("$root","")}
      $toolFilesURLs = $toolFilesSubpath | foreach {("$rawGithub"+"$_").Replace("\","/")}

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