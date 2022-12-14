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

#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: 7f4abe24-a843-4d3f-8d3b-862bb762d164
# Source File: RockyDLTool.psproj
#------------------------------------------------------------------------
#region Project Recovery Data (DO NOT MODIFY)
<#RecoveryData:
TwIAAB+LCAAAAAAABACFUl9rgzAcfC/0O0geB9ZqpS0szcMojsL+UUtfR9SfM2tMJMau7tMvGjta
trGXX3LJecedwVtI5RFUu6aakvHIcfCLku+QaiduRVooKdgnZCsUUV4D6g8jxjWoFbqZVLV/283S
Lpld/FPJ+03ez9pMe1IAryb6pFFvZKz2oGomBQkmPvbOYLgzLrBZk0Ue0gSC0KXLcOaG2Sx3l9ks
cZfzIEkW8yDz5yH2BvLw6ZBg11ZApti7hGdxyTNj53iXbvUABujcNYyb5FNEYk2VbqoujPX6i+nE
BVVdXTvVmLa2kIMCkULUiFSbcCu0EUd5APeey4TyV1MWInZfd839o/6LXlzID/eRMhFJVRq9HJEz
6v7AlaAFNuZ3LRY9K/bGBOUd4YmWQLYyPbTrh52U3OhUhou9H6TxCHtXD+gL8UT6cU8CAAA=#>
#endregion
<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.160
     Generated on:       28.12.2022 21:58
     Generated by:       Rockschuppen
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2019
#>



#region Source: Startup.pss
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
YQAAAB+LCAAAAAAABACzCUpNzi9LLap0SSxJVAAyijPz82yVjPUMlex4uRQUbPyLMtMz8xJz3DJz
Uv0Sc1PtgksSi0pKC/QKiott9DFkebls9JGNtAMAoyFkEGEAAAA=#>
#endregion
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
		
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)
		
	#--------------------------------------------------------------------------
	#TODO: Add initialization script here (Load modules and check requirements)
	
	
	#--------------------------------------------------------------------------
	
	if((Show-MainForm_psf) -eq 'OK')
	{
		
	}
	
	$script:ExitCode = 0 #Set the exit code for the Packager
}


#endregion Source: Startup.pss

#region Source: Globals.ps1
	#--------------------------------------------
	# Declare Global Variables and Functions here
	#--------------------------------------------
	
	#Define release and paths
	$global:rls = "Spider-Man.No.Way.Home.2021.German.AC3.Dubbed.BDRip.x264-PsO"
	
	$global:root = ([IO.FileInfo]$MyInvocation.MyCommand.Path).Directory.Parent.FullName
	$global:base = ([IO.FileInfo]$MyInvocation.MyCommand.Path).Directory.Parent.Parent.FullName
	
	$global:dataPath = "$root\data"
	$global:functionsPath = "$root\functions"
	
	#Unblock all files downloaded from the internet
	Get-ChildItem "$root" -Recurse | Unblock-File
	
	#Detect OS version
	$global:osVersion = (Get-WmiObject -class Win32_OperatingSystem).Caption -replace "[^0-9]", ''
	
	#Update EdgeDriver
	. "$functionsPath\Update-EdgeDriver.ps1"
	
	#Read passwords, encrypt if needed
	. "$functionsPath\Get-Passwords.ps1"
	
	$global:browserHidden = $true
	
	#Sample function that provides the location of the script
	function Get-ScriptDirectory
	{
	<#
		.SYNOPSIS
			Get-ScriptDirectory returns the proper location of the script.
	
		.OUTPUTS
			System.String
		
		.NOTES
			Returns the correct path within a packaged executable.
	#>
		[OutputType([string])]
		param ()
		if ($null -ne $hostinvocation)
		{
			Split-Path $hostinvocation.MyCommand.path
		}
		else
		{
			Split-Path $script:MyInvocation.MyCommand.Path
		}
	}
	
	#Sample variable that provides the location of the script
	[string]$ScriptDirectory = Get-ScriptDirectory
	
	function Reset-Tool
	{
		$topReleases = (Invoke-RestMethod -Uri "https://api.xrel.to/v2/release/browse_category.json?category_name=topmovie&ext_info_type=movie&per_page=100&page=1" | Select -expand list | Where { $_.video_type -eq "Web-Rip" -OR $_.video_type -eq "Blu-ray" } | Where { ($_.dirname -like "*2021*" -OR $_.dirname -like "*2022*" -OR $_.dirname -like "*2023*" -OR $_.dirname -like "*2024*") -AND ($_.dirname -like "*1080p*" -OR $_.dirname -like "*2160p*") }).dirname
		$listboxTopRls.Items.Clear()
		foreach ($release in $topReleases)
		{
			Update-ListBox -ListBox $listboxTopRls "$release" -Append
		}
		$progressbar1.value = 0
		
		$btn_Boerse.BackColor = 'ControlLightLight'
		$btn_DataLoad.BackColor = 'ControlLightLight'
		$btn_HDSource.BackColor = 'ControlLightLight'
		$btn_StarWarez.BackColor = 'ControlLightLight'
		$btn_DDLWarez.BackColor = 'ControlLightLight'
		$btn_MovieBlogArea.BackColor = 'ControlLightLight'
		$btn_VideothekCX.BackColor = 'ControlLightLight'
		$searchRls.Text = ""
	}
	function Reset-Tool_Games
	{
		$topReleases_Games = (Invoke-RestMethod -Uri "https://api.xrel.to/v2/release/browse_category.json?category_name=Topgame&per_page=100&page=1" | Select -expand list | Where { $_.ext_info.type -eq "game" }).dirname
		$listboxTopRls_Games.Items.Clear()
		foreach ($release in $topReleases_Games)
		{
			Update-ListBox -ListBox $listboxTopRls_Games "$release" -Append
		}
		$progressbar1_Games.value = 0
		
		$btn_GLOAD.BackColor = 'ControlLightLight'
		$btn_G4U.BackColor = 'ControlLightLight'
		$searchRls_Games.Text = ""
	}
#endregion Source: Globals.ps1

#region Source: MainForm.psf
function Show-MainForm_psf
{
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
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
H/j/tm5//we7byBlyQkAAA==#>
#endregion
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formRockysULtimateDLFind = New-Object 'System.Windows.Forms.Form'
	$tabcontrol1 = New-Object 'System.Windows.Forms.TabControl'
	$tabpage1 = New-Object 'System.Windows.Forms.TabPage'
	$btn_tbd3 = New-Object 'System.Windows.Forms.Button'
	$btn_tbd2 = New-Object 'System.Windows.Forms.Button'
	$btn_tbd1 = New-Object 'System.Windows.Forms.Button'
	$btn_tbd4 = New-Object 'System.Windows.Forms.Button'
	$btn_tbd5 = New-Object 'System.Windows.Forms.Button'
	$btn_VideothekCX = New-Object 'System.Windows.Forms.Button'
	$btn_Search = New-Object 'System.Windows.Forms.Button'
	$listboxTopRls = New-Object 'System.Windows.Forms.ListBox'
	$rb_NoHD = New-Object 'System.Windows.Forms.RadioButton'
	$btn_Boerse = New-Object 'System.Windows.Forms.Button'
	$rb_HD = New-Object 'System.Windows.Forms.RadioButton'
	$progressbar1 = New-Object 'System.Windows.Forms.ProgressBar'
	$btn_Reset = New-Object 'System.Windows.Forms.Button'
	$searchRls = New-Object 'System.Windows.Forms.TextBox'
	$btn_Go = New-Object 'System.Windows.Forms.Button'
	$btn_DataLoad = New-Object 'System.Windows.Forms.Button'
	$btn_MovieBlogArea = New-Object 'System.Windows.Forms.Button'
	$btn_HDSource = New-Object 'System.Windows.Forms.Button'
	$btn_DDLWarez = New-Object 'System.Windows.Forms.Button'
	$btn_StarWarez = New-Object 'System.Windows.Forms.Button'
	$tabpage2 = New-Object 'System.Windows.Forms.TabPage'
	$tabpage3 = New-Object 'System.Windows.Forms.TabPage'
	$tabpage4 = New-Object 'System.Windows.Forms.TabPage'
	$btn_GLOAD = New-Object 'System.Windows.Forms.Button'
	$btn_G4U = New-Object 'System.Windows.Forms.Button'
	$btn_Search_Games = New-Object 'System.Windows.Forms.Button'
	$progressbar1_Games = New-Object 'System.Windows.Forms.ProgressBar'
	$btn_Reset_Games = New-Object 'System.Windows.Forms.Button'
	$searchRls_Games = New-Object 'System.Windows.Forms.TextBox'
	$btn_Go_Games = New-Object 'System.Windows.Forms.Button'
	$listboxTopRls_Games = New-Object 'System.Windows.Forms.ListBox'
	$tooltip1 = New-Object 'System.Windows.Forms.ToolTip'
	$tooltip1.AutoPopDelay = 4500
	$tooltip1.InitialDelay = 1000
	$tooltip1.ReshowDelay = 500
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$formRockysULtimateDLFind_Load={
		#TODO: Initialize Form Controls here
		$global:tabNumber = $tabcontrol1.SelectedIndex + 1
		
		if ($tabNumber -eq 1)
		{
			$rb_HD.Checked = $true
			Reset-Tool
		}
	}
	
	#region Control Helper Functions
	function Update-ComboBox
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ComboBox.
		
		.DESCRIPTION
			Use this function to dynamically load items into the ComboBox control.
		
		.PARAMETER ComboBox
			The ComboBox control you want to add items to.
		
		.PARAMETER Items
			The object or objects you wish to load into the ComboBox's Items collection.
		
		.PARAMETER DisplayMember
			Indicates the property to display for the items in this control.
			
		.PARAMETER ValueMember
			Indicates the property to use for the value of the control.
		
		.PARAMETER Append
			Adds the item(s) to the ComboBox without clearing the Items collection.
		
		.EXAMPLE
			Update-ComboBox $combobox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Update-ComboBox $combobox1 "Red" -Append
			Update-ComboBox $combobox1 "White" -Append
			Update-ComboBox $combobox1 "Blue" -Append
		
		.EXAMPLE
			Update-ComboBox $combobox1 (Get-Process) "ProcessName"
		
		.NOTES
			Additional information about the function.
	#>
		
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ComboBox]
			$ComboBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[Parameter(Mandatory = $false)]
			[string]$DisplayMember,
			[Parameter(Mandatory = $false)]
			[string]$ValueMember,
			[switch]
			$Append
		)
		
		if (-not $Append)
		{
			$ComboBox.Items.Clear()
		}
		
		if ($Items -is [Object[]])
		{
			$ComboBox.Items.AddRange($Items)
		}
		elseif ($Items -is [System.Collections.IEnumerable])
		{
			$ComboBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ComboBox.Items.Add($obj)
			}
			$ComboBox.EndUpdate()
		}
		else
		{
			$ComboBox.Items.Add($Items)
		}
		
		$ComboBox.DisplayMember = $DisplayMember
		$ComboBox.ValueMember = $ValueMember
	}
	
	function Update-ListBox
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ListBox or CheckedListBox.
		
		.DESCRIPTION
			Use this function to dynamically load items into the ListBox control.
		
		.PARAMETER ListBox
			The ListBox control you want to add items to.
		
		.PARAMETER Items
			The object or objects you wish to load into the ListBox's Items collection.
		
		.PARAMETER DisplayMember
			Indicates the property to display for the items in this control.
			
		.PARAMETER ValueMember
			Indicates the property to use for the value of the control.
		
		.PARAMETER Append
			Adds the item(s) to the ListBox without clearing the Items collection.
		
		.EXAMPLE
			Update-ListBox $ListBox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Update-ListBox $listBox1 "Red" -Append
			Update-ListBox $listBox1 "White" -Append
			Update-ListBox $listBox1 "Blue" -Append
		
		.EXAMPLE
			Update-ListBox $listBox1 (Get-Process) "ProcessName"
		
		.NOTES
			Additional information about the function.
	#>
		
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ListBox]
			$ListBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[Parameter(Mandatory = $false)]
			[string]$DisplayMember,
			[Parameter(Mandatory = $false)]
			[string]$ValueMember,
			[switch]
			$Append
		)
		
		if (-not $Append)
		{
			$ListBox.Items.Clear()
		}
		
		if ($Items -is [System.Windows.Forms.ListBox+ObjectCollection] -or $Items -is [System.Collections.ICollection])
		{
			$ListBox.Items.AddRange($Items)
		}
		elseif ($Items -is [System.Collections.IEnumerable])
		{
			$ListBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ListBox.Items.Add($obj)
			}
			$ListBox.EndUpdate()
		}
		else
		{
			$ListBox.Items.Add($Items)
		}
		
		$ListBox.DisplayMember = $DisplayMember
		$ListBox.ValueMember = $ValueMember
	}
	#endregion
	
	$btn_Boerse_Click={
		#TODO: Place custom script here
		Start-Process "$boerseLink"
	}
	
	$btn_DataLoad_Click={
		#TODO: Place custom script here
		Start-Process "$dataLoadLink"
	}
	
	$btn_HDSource_Click={
		#TODO: Place custom script here
		Start-Process "$hdSourceLink"
	}
	
	$btn_StarWarez_Click={
		#TODO: Place custom script here
		Start-Process "$starWarezLink"
	}
	
	$btn_DDLWarez_Click={
		#TODO: Place custom script here
		Start-Process "$ddlWarezLink"
	}
	
	$btn_MovieBlogArea_Click={
		#TODO: Place custom script here
		Start-Process "$movieBlogAreaLink"
	}
	
	$btn_VideothekCX_Click = {
		#TODO: Place custom script here
		Start-Process "$videoThekCXLink"
	}
	
	$btn_GLOAD_Click = {
		#TODO: Place custom script here
		Start-Process "$gloadLink"
	}
	
	$btn_G4U_Click = {
		#TODO: Place custom script here
		Start-Process "$g4uLink"
	}
	
	$btn_Go_Click = {
		if ($tabNumber -eq 1)
		{
			$global:boerseLink = $null
			$global:dataLoadLink = $null
			$global:hdSourceLink = $null
			$global:starWarezLink = $null
			$global:ddlWarezLink = $null
			$global:movieBlogAreaLink = $null
			$global:videoThekCXLink = $null
			
			#TODO: Place custom script here
			$rls = $listboxTopRls.Text
			
			$btn_Boerse.BackColor = 'ControlLightLight'
			$btn_DataLoad.BackColor = 'ControlLightLight'
			$btn_HDSource.BackColor = 'ControlLightLight'
			$btn_StarWarez.BackColor = 'ControlLightLight'
			$btn_DDLWarez.BackColor = 'ControlLightLight'
			$btn_MovieBlogArea.BackColor = 'ControlLightLight'
			$btn_VideothekCX.BackColor = 'ControlLightLight'
			
			$progressbar1.Value = 0
			1 .. 15 | foreach{
				Start-Sleep -Milliseconds 100
				$progressbar1.Value++
			}
			
		<#
		. "$functionsPath\Search-Boerse.ps1"
		if ($boerseLink -ne $null)
		{
			$btn_Boerse.BackColor = '0, 192, 0'
		}
		#>
			
			$progressbar1.Value = 17
			
			. "$functionsPath\Search-DataLoad.ps1"
			if ($dataLoadLink -ne $null)
			{
				$btn_DataLoad.BackColor = '0, 192, 0'
			}
			$progressbar1.Value = 34
			
			. "$functionsPath\Search-HDSource.ps1"
			if ($hdSourceLink -ne $null)
			{
				$btn_HDSource.BackColor = '0, 192, 0'
			}
			$progressbar1.Value = 51
			
			. "$functionsPath\Search-StarWarez.ps1"
			if ($starWarezLink -ne $null)
			{
				$btn_StarWarez.BackColor = '0, 192, 0'
			}
			$progressbar1.Value = 68
			
			. "$functionsPath\Search-DDLWarez.ps1"
			if ($ddlWarezLink -ne $null)
			{
				$btn_DDLWarez.BackColor = '0, 192, 0'
			}
			$progressbar1.Value = 75
			
			. "$functionsPath\Search-MovieBlogArea.ps1"
			if ($movieBlogAreaLink -ne $null)
			{
				$btn_MovieBlogArea.BackColor = '0, 192, 0'
			}
			$progressbar1.Value = 85
			
			. "$functionsPath\Search-VideothekCX.ps1"
			if ($videoThekCXLink -ne $null)
			{
				$btn_VideothekCX.BackColor = '0, 192, 0'
			}
			$progressbar1.Value = 100
		}
	}
	
	$btn_Go_Games_Click = {
		$global:gloadLink = $null
		$global:g4uLink = $null
			
		#TODO: Place custom script here
		$rls = $listboxTopRls_Games.Text
			
		$btn_GLOAD.BackColor = 'ControlLightLight'
		$btn_G4U.BackColor = 'ControlLightLight'
			
		$progressbar1_Games.Value = 0
		1 .. 15 | foreach{
			Start-Sleep -Milliseconds 100
			$progressbar1_Games.Value++
		}
			
		$progressbar1_Games.Value = 17
			
		. "$functionsPath\Search-Gload.ps1"
		if ($gloadLink -ne $null)
		{
			$btn_GLOAD.BackColor = '0, 192, 0'
		}
		$progressbar1_Games.Value = 55
			
		. "$functionsPath\Search-G4U.ps1"
		if ($g4uLink -ne $null)
		{
			$btn_G4U.BackColor = '0, 192, 0'
		}
			
		$progressbar1_Games.Value = 100
	}
	
	$btn_Reset_Click={
		#TODO: Place custom script here
		Reset-Tool
	}
	
	$btn_Reset_Games_Click = {
		#TODO: Place custom script here
		Reset-Tool_Games
	}
	
	$btn_Search_Click={
		#TODO: Place custom script here
		$listboxTopRls.Items.Clear()
		$search = $searchRls.Text
		if ($rb_HD.Checked -eq $true)
		{
			$searchReleases = ((Invoke-RestMethod -Uri "https://api.xrel.to/v2/search/releases.json?q=$search").results | Where{ ($_.video_type -eq "Web-Rip" -OR $_.video_type -eq "Blu-ray") -AND ($_.dirname -like "*2160p*" -OR $_.dirname -like "*1080p*") }).dirname
		}
		if ($rb_NoHD.Checked -eq $true)
		{
			$searchReleases = ((Invoke-RestMethod -Uri "https://api.xrel.to/v2/search/releases.json?q=$search").results | Where{ ($_.video_type -eq "Web-Rip" -OR $_.video_type -eq "Blu-ray") -AND ($_.dirname -notlike "*2160p*" -AND $_.dirname -notlike "*1080p*") }).dirname
		}
			
		foreach ($searchRelease in $searchReleases)
		{
			Update-ListBox -ListBox $listboxTopRls "$searchRelease" -Append
		}
			
		$global:boerseLink = $null
		$global:dataLoadLink = $null
		$global:hdSourceLink = $null
		$global:starWarezLink = $null
		$global:ddlWarezLink = $null
		$global:movieBlogAreaLink = $null
		$global:videoThekCXLink = $null
	}
	
	$btn_Search_Games_Click = {
		#TODO: Place custom script here
		$listboxTopRls_Games.Items.Clear()
		$search = $searchRls_Games.Text
		
		$searchReleases = ((Invoke-RestMethod -Uri "https://api.xrel.to/v2/search/releases.json?q=$search").results | Where { $_.ext_info.type -eq "game" }).dirname
		
		foreach ($searchRelease in $searchReleases)
		{
			Update-ListBox -ListBox $listboxTopRls_Games "$searchRelease" -Append
		}
		
		$global:gloadLink = $null
		$global:g4uLink = $null
	}
	
	$listboxTopRls.add_DoubleClick({
			$listboxElement = $listboxTopRls.Text
			$listboxElement
			$xRelLink = (Invoke-RestMethod -Uri "https://api.xrel.to/v2/search/releases.json?q=$listboxElement").results.link_href
			Start-Process "$xRelLink"
	})
	
	$listboxTopRls_Games.add_DoubleClick({
			$listboxElement = $listboxTopRls_Games.Text
			$listboxElement
			$xRelLink = (Invoke-RestMethod -Uri "https://api.xrel.to/v2/search/releases.json?q=$listboxElement").results.link_href
			Start-Process "$xRelLink"
	})
	
	$listboxTopRls.add_MouseHover({
			
			$point = $listboxTopRls.PointToClient([System.Windows.Forms.Control]::MousePosition)
			$index = $listboxTopRls.IndexFromPoint($point)
			
			if ($index -ge 0)
			{
				$tooltip1.SetToolTip($listboxTopRls, $listboxTopRls.GetItemText($listboxTopRls.Items[$index]))
			}
	})
	
	$listboxTopRls_Games.add_MouseHover({
			
			$point = $listboxTopRls_Games.PointToClient([System.Windows.Forms.Control]::MousePosition)
			$index = $listboxTopRls_Games.IndexFromPoint($point)
			
			if ($index -ge 0)
			{
				$tooltip1.SetToolTip($listboxTopRls_Games, $listboxTopRls_Games.GetItemText($listboxTopRls_Games.Items[$index]))
			}
	})
	
	$tabcontrol1_SelectedIndexChanged={
		#TODO: Place custom script here
		$tabNumber = $tabcontrol1.SelectedIndex + 1
		
		if ($tabNumber -eq 1)
		{
			$rb_HD.Checked = $true
			Reset-Tool
		}
		if ($tabNumber -eq 4)
		{
			Reset-Tool_Games
		}
	}
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formRockysULtimateDLFind.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_listboxTopRls = $listboxTopRls.SelectedItems
		$script:MainForm_rb_NoHD = $rb_NoHD.Checked
		$script:MainForm_rb_HD = $rb_HD.Checked
		$script:MainForm_searchRls = $searchRls.Text
		$script:MainForm_searchRls_Games = $searchRls_Games.Text
		$script:MainForm_listboxTopRls_Games = $listboxTopRls_Games.SelectedItems
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$btn_VideothekCX.remove_Click($btn_VideothekCX_Click)
			$btn_Search.remove_Click($btn_Search_Click)
			$btn_Boerse.remove_Click($btn_Boerse_Click)
			$btn_Reset.remove_Click($btn_Reset_Click)
			$btn_Go.remove_Click($btn_Go_Click)
			$btn_DataLoad.remove_Click($btn_DataLoad_Click)
			$btn_MovieBlogArea.remove_Click($btn_MovieBlogArea_Click)
			$btn_HDSource.remove_Click($btn_HDSource_Click)
			$btn_DDLWarez.remove_Click($btn_DDLWarez_Click)
			$btn_StarWarez.remove_Click($btn_StarWarez_Click)
			$btn_GLOAD.remove_Click($btn_GLOAD_Click)
			$btn_G4U.remove_Click($btn_G4U_Click)
			$btn_Search_Games.remove_Click($btn_Search_Games_Click)
			$btn_Reset_Games.remove_Click($btn_Reset_Games_Click)
			$btn_Go_Games.remove_Click($btn_Go_Games_Click)
			$tabcontrol1.remove_SelectedIndexChanged($tabcontrol1_SelectedIndexChanged)
			$formRockysULtimateDLFind.remove_Load($formRockysULtimateDLFind_Load)
			$formRockysULtimateDLFind.remove_Load($Form_StateCorrection_Load)
			$formRockysULtimateDLFind.remove_Closing($Form_StoreValues_Closing)
			$formRockysULtimateDLFind.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formRockysULtimateDLFind.SuspendLayout()
	$tabcontrol1.SuspendLayout()
	$tabpage1.SuspendLayout()
	$tabpage4.SuspendLayout()
	#
	# formRockysULtimateDLFind
	#
	$formRockysULtimateDLFind.Controls.Add($tabcontrol1)
	$formRockysULtimateDLFind.AutoScaleDimensions = '8, 17'
	$formRockysULtimateDLFind.AutoScaleMode = 'Font'
	$formRockysULtimateDLFind.BackColor = 'ControlLightLight'
	$formRockysULtimateDLFind.ClientSize = '868, 600'
	$formRockysULtimateDLFind.FormBorderStyle = 'FixedDialog'
	$formRockysULtimateDLFind.Margin = '5, 5, 5, 5'
	$formRockysULtimateDLFind.MaximizeBox = $False
	$formRockysULtimateDLFind.MinimizeBox = $False
	$formRockysULtimateDLFind.Name = 'formRockysULtimateDLFind'
	$formRockysULtimateDLFind.StartPosition = 'CenterScreen'
	$formRockysULtimateDLFind.Text = 'Rockys Ultimate DL Finder Tool'
	$formRockysULtimateDLFind.add_Load($formRockysULtimateDLFind_Load)
	#
	# tabcontrol1
	#
	$tabcontrol1.Controls.Add($tabpage1)
	$tabcontrol1.Controls.Add($tabpage2)
	$tabcontrol1.Controls.Add($tabpage3)
	$tabcontrol1.Controls.Add($tabpage4)
	$tabcontrol1.Location = '-4, -1'
	$tabcontrol1.Margin = '4, 4, 4, 4'
	$tabcontrol1.Name = 'tabcontrol1'
	$tabcontrol1.SelectedIndex = 0
	$tabcontrol1.Size = '878, 608'
	$tabcontrol1.TabIndex = 101
	$tabcontrol1.add_SelectedIndexChanged($tabcontrol1_SelectedIndexChanged)
	#
	# tabpage1
	#
	$tabpage1.Controls.Add($btn_tbd3)
	$tabpage1.Controls.Add($btn_tbd2)
	$tabpage1.Controls.Add($btn_tbd1)
	$tabpage1.Controls.Add($btn_tbd4)
	$tabpage1.Controls.Add($btn_tbd5)
	$tabpage1.Controls.Add($btn_VideothekCX)
	$tabpage1.Controls.Add($btn_Search)
	$tabpage1.Controls.Add($listboxTopRls)
	$tabpage1.Controls.Add($rb_NoHD)
	$tabpage1.Controls.Add($btn_Boerse)
	$tabpage1.Controls.Add($rb_HD)
	$tabpage1.Controls.Add($progressbar1)
	$tabpage1.Controls.Add($btn_Reset)
	$tabpage1.Controls.Add($searchRls)
	$tabpage1.Controls.Add($btn_Go)
	$tabpage1.Controls.Add($btn_DataLoad)
	$tabpage1.Controls.Add($btn_MovieBlogArea)
	$tabpage1.Controls.Add($btn_HDSource)
	$tabpage1.Controls.Add($btn_DDLWarez)
	$tabpage1.Controls.Add($btn_StarWarez)
	$tabpage1.Location = '4, 26'
	$tabpage1.Margin = '4, 4, 4, 4'
	$tabpage1.Name = 'tabpage1'
	$tabpage1.Padding = '3, 3, 3, 3'
	$tabpage1.Size = '870, 578'
	$tabpage1.TabIndex = 0
	$tabpage1.Text = 'HD Moviez'
	$tabpage1.UseVisualStyleBackColor = $True
	#
	# btn_tbd3
	#
	$btn_tbd3.Location = '751, 246'
	$btn_tbd3.Margin = '4, 4, 4, 4'
	$btn_tbd3.Name = 'btn_tbd3'
	$btn_tbd3.Size = '70, 70'
	$btn_tbd3.TabIndex = 106
	$btn_tbd3.Text = 'X'
	$btn_tbd3.UseCompatibleTextRendering = $True
	$btn_tbd3.UseVisualStyleBackColor = $True
	#
	# btn_tbd2
	#
	$btn_tbd2.Location = '673, 246'
	$btn_tbd2.Margin = '4, 4, 4, 4'
	$btn_tbd2.Name = 'btn_tbd2'
	$btn_tbd2.Size = '70, 70'
	$btn_tbd2.TabIndex = 105
	$btn_tbd2.Text = 'X'
	$btn_tbd2.UseCompatibleTextRendering = $True
	$btn_tbd2.UseVisualStyleBackColor = $True
	#
	# btn_tbd1
	#
	$btn_tbd1.Location = '595, 246'
	$btn_tbd1.Margin = '4, 4, 4, 4'
	$btn_tbd1.Name = 'btn_tbd1'
	$btn_tbd1.Size = '70, 70'
	$btn_tbd1.TabIndex = 104
	$btn_tbd1.Text = 'X'
	$btn_tbd1.UseCompatibleTextRendering = $True
	$btn_tbd1.UseVisualStyleBackColor = $True
	#
	# btn_tbd4
	#
	$btn_tbd4.Location = '751, 168'
	$btn_tbd4.Margin = '4, 4, 4, 4'
	$btn_tbd4.Name = 'btn_tbd4'
	$btn_tbd4.Size = '70, 70'
	$btn_tbd4.TabIndex = 103
	$btn_tbd4.Text = 'X'
	$btn_tbd4.UseCompatibleTextRendering = $True
	$btn_tbd4.UseVisualStyleBackColor = $True
	#
	# btn_tbd5
	#
	$btn_tbd5.Location = '751, 90'
	$btn_tbd5.Margin = '4, 4, 4, 4'
	$btn_tbd5.Name = 'btn_tbd5'
	$btn_tbd5.Size = '70, 70'
	$btn_tbd5.TabIndex = 102
	$btn_tbd5.Text = 'X'
	$btn_tbd5.UseCompatibleTextRendering = $True
	$btn_tbd5.UseVisualStyleBackColor = $True
	#
	# btn_VideothekCX
	#
	$btn_VideothekCX.Location = '751, 12'
	$btn_VideothekCX.Margin = '4, 4, 4, 4'
	$btn_VideothekCX.Name = 'btn_VideothekCX'
	$btn_VideothekCX.Size = '70, 70'
	$btn_VideothekCX.TabIndex = 101
	$btn_VideothekCX.Text = 'Video- thek.cx'
	$btn_VideothekCX.UseCompatibleTextRendering = $True
	$btn_VideothekCX.UseVisualStyleBackColor = $True
	$btn_VideothekCX.add_Click($btn_VideothekCX_Click)
	#
	# btn_Search
	#
	$btn_Search.Location = '24, 386'
	$btn_Search.Margin = '4, 4, 4, 4'
	$btn_Search.Name = 'btn_Search'
	$btn_Search.Size = '148, 30'
	$btn_Search.TabIndex = 2
	$btn_Search.Text = 'Search'
	$btn_Search.UseCompatibleTextRendering = $True
	$btn_Search.UseVisualStyleBackColor = $True
	$btn_Search.add_Click($btn_Search_Click)
	#
	# listboxTopRls
	#
	$listboxTopRls.FormattingEnabled = $True
	$listboxTopRls.ItemHeight = 17
	$listboxTopRls.Location = '24, 12'
	$listboxTopRls.Margin = '4, 4, 4, 4'
	$listboxTopRls.Name = 'listboxTopRls'
	$listboxTopRls.Size = '529, 310'
	$listboxTopRls.TabIndex = 40
	$listboxTopRls.TabStop = $False
	#
	# rb_NoHD
	#
	$rb_NoHD.Location = '437, 367'
	$rb_NoHD.Margin = '4, 4, 4, 4'
	$rb_NoHD.Name = 'rb_NoHD'
	$rb_NoHD.Size = '139, 31'
	$rb_NoHD.TabIndex = 22
	$rb_NoHD.Text = 'any other'
	$rb_NoHD.UseCompatibleTextRendering = $True
	$rb_NoHD.UseVisualStyleBackColor = $True
	#
	# btn_Boerse
	#
	$btn_Boerse.BackColor = 'ControlLightLight'
	$btn_Boerse.Enabled = $False
	$btn_Boerse.Location = '595, 12'
	$btn_Boerse.Margin = '4, 4, 4, 4'
	$btn_Boerse.Name = 'btn_Boerse'
	$btn_Boerse.Size = '70, 70'
	$btn_Boerse.TabIndex = 6
	$btn_Boerse.Text = 'Boerse'
	$btn_Boerse.UseCompatibleTextRendering = $True
	$btn_Boerse.UseVisualStyleBackColor = $False
	$btn_Boerse.add_Click($btn_Boerse_Click)
	#
	# rb_HD
	#
	$rb_HD.Location = '437, 339'
	$rb_HD.Margin = '4, 4, 4, 4'
	$rb_HD.Name = 'rb_HD'
	$rb_HD.Size = '139, 31'
	$rb_HD.TabIndex = 100
	$rb_HD.Text = '2160p / 1080p'
	$rb_HD.UseCompatibleTextRendering = $True
	$rb_HD.UseVisualStyleBackColor = $True
	#
	# progressbar1
	#
	$progressbar1.Location = '24, 452'
	$progressbar1.Margin = '4, 4, 4, 4'
	$progressbar1.Name = 'progressbar1'
	$progressbar1.Size = '816, 30'
	$progressbar1.TabIndex = 100
	#
	# btn_Reset
	#
	$btn_Reset.Location = '595, 328'
	$btn_Reset.Margin = '4, 4, 4, 4'
	$btn_Reset.Name = 'btn_Reset'
	$btn_Reset.Size = '226, 30'
	$btn_Reset.TabIndex = 20
	$btn_Reset.Text = 'Reset Search'
	$btn_Reset.UseCompatibleTextRendering = $True
	$btn_Reset.UseVisualStyleBackColor = $True
	$btn_Reset.add_Click($btn_Reset_Click)
	#
	# searchRls
	#
	$searchRls.AccessibleName = ''
	$searchRls.Location = '24, 355'
	$searchRls.Margin = '4, 4, 4, 4'
	$searchRls.Name = 'searchRls'
	$searchRls.Size = '387, 23'
	$searchRls.TabIndex = 0
	#
	# btn_Go
	#
	$btn_Go.Location = '707, 507'
	$btn_Go.Margin = '4, 4, 4, 4'
	$btn_Go.Name = 'btn_Go'
	$btn_Go.Size = '133, 30'
	$btn_Go.TabIndex = 4
	$btn_Go.Text = '&Go for that shit'
	$btn_Go.UseCompatibleTextRendering = $True
	$btn_Go.UseVisualStyleBackColor = $True
	$btn_Go.add_Click($btn_Go_Click)
	#
	# btn_DataLoad
	#
	$btn_DataLoad.Location = '673, 12'
	$btn_DataLoad.Margin = '4, 4, 4, 4'
	$btn_DataLoad.Name = 'btn_DataLoad'
	$btn_DataLoad.Size = '70, 70'
	$btn_DataLoad.TabIndex = 8
	$btn_DataLoad.Text = 'Data-Load'
	$btn_DataLoad.UseCompatibleTextRendering = $True
	$btn_DataLoad.UseVisualStyleBackColor = $True
	$btn_DataLoad.add_Click($btn_DataLoad_Click)
	#
	# btn_MovieBlogArea
	#
	$btn_MovieBlogArea.Location = '673, 168'
	$btn_MovieBlogArea.Margin = '4, 4, 4, 4'
	$btn_MovieBlogArea.Name = 'btn_MovieBlogArea'
	$btn_MovieBlogArea.Size = '70, 70'
	$btn_MovieBlogArea.TabIndex = 16
	$btn_MovieBlogArea.Text = 'Movie Blog Area'
	$btn_MovieBlogArea.UseCompatibleTextRendering = $True
	$btn_MovieBlogArea.UseVisualStyleBackColor = $True
	$btn_MovieBlogArea.add_Click($btn_MovieBlogArea_Click)
	#
	# btn_HDSource
	#
	$btn_HDSource.BackColor = 'ControlLightLight'
	$btn_HDSource.Location = '595, 90'
	$btn_HDSource.Margin = '4, 4, 4, 4'
	$btn_HDSource.Name = 'btn_HDSource'
	$btn_HDSource.Size = '70, 70'
	$btn_HDSource.TabIndex = 10
	$btn_HDSource.Text = 'HD-Source'
	$btn_HDSource.UseCompatibleTextRendering = $True
	$btn_HDSource.UseVisualStyleBackColor = $False
	$btn_HDSource.add_Click($btn_HDSource_Click)
	#
	# btn_DDLWarez
	#
	$btn_DDLWarez.Location = '595, 168'
	$btn_DDLWarez.Margin = '4, 4, 4, 4'
	$btn_DDLWarez.Name = 'btn_DDLWarez'
	$btn_DDLWarez.Size = '70, 70'
	$btn_DDLWarez.TabIndex = 14
	$btn_DDLWarez.Text = 'DDL-Warez'
	$btn_DDLWarez.UseCompatibleTextRendering = $True
	$btn_DDLWarez.UseVisualStyleBackColor = $True
	$btn_DDLWarez.add_Click($btn_DDLWarez_Click)
	#
	# btn_StarWarez
	#
	$btn_StarWarez.Location = '673, 90'
	$btn_StarWarez.Margin = '4, 4, 4, 4'
	$btn_StarWarez.Name = 'btn_StarWarez'
	$btn_StarWarez.Size = '70, 70'
	$btn_StarWarez.TabIndex = 12
	$btn_StarWarez.Text = 'Star Warez'
	$btn_StarWarez.UseCompatibleTextRendering = $True
	$btn_StarWarez.UseVisualStyleBackColor = $True
	$btn_StarWarez.add_Click($btn_StarWarez_Click)
	#
	# tabpage2
	#
	$tabpage2.Location = '4, 26'
	$tabpage2.Margin = '4, 4, 4, 4'
	$tabpage2.Name = 'tabpage2'
	$tabpage2.Padding = '3, 3, 3, 3'
	$tabpage2.Size = '870, 578'
	$tabpage2.TabIndex = 1
	$tabpage2.Text = 'Streamz'
	$tabpage2.UseVisualStyleBackColor = $True
	#
	# tabpage3
	#
	$tabpage3.Location = '4, 26'
	$tabpage3.Margin = '4, 4, 4, 4'
	$tabpage3.Name = 'tabpage3'
	$tabpage3.Size = '870, 578'
	$tabpage3.TabIndex = 2
	$tabpage3.Text = 'Seriez'
	$tabpage3.UseVisualStyleBackColor = $True
	#
	# tabpage4
	#
	$tabpage4.Controls.Add($btn_GLOAD)
	$tabpage4.Controls.Add($btn_G4U)
	$tabpage4.Controls.Add($btn_Search_Games)
	$tabpage4.Controls.Add($progressbar1_Games)
	$tabpage4.Controls.Add($btn_Reset_Games)
	$tabpage4.Controls.Add($searchRls_Games)
	$tabpage4.Controls.Add($btn_Go_Games)
	$tabpage4.Controls.Add($listboxTopRls_Games)
	$tabpage4.Location = '4, 26'
	$tabpage4.Margin = '4, 4, 4, 4'
	$tabpage4.Name = 'tabpage4'
	$tabpage4.Size = '870, 578'
	$tabpage4.TabIndex = 3
	$tabpage4.Text = 'Gamez'
	$tabpage4.UseVisualStyleBackColor = $True
	#
	# btn_GLOAD
	#
	$btn_GLOAD.BackColor = 'ControlLightLight'
	$btn_GLOAD.Location = '595, 12'
	$btn_GLOAD.Margin = '4, 4, 4, 4'
	$btn_GLOAD.Name = 'btn_GLOAD'
	$btn_GLOAD.Size = '70, 70'
	$btn_GLOAD.TabIndex = 106
	$btn_GLOAD.Text = 'GLOAD'
	$btn_GLOAD.UseCompatibleTextRendering = $True
	$btn_GLOAD.UseVisualStyleBackColor = $False
	$btn_GLOAD.add_Click($btn_GLOAD_Click)
	#
	# btn_G4U
	#
	$btn_G4U.Location = '673, 12'
	$btn_G4U.Margin = '4, 4, 4, 4'
	$btn_G4U.Name = 'btn_G4U'
	$btn_G4U.Size = '70, 70'
	$btn_G4U.TabIndex = 107
	$btn_G4U.Text = 'G4U'
	$btn_G4U.UseCompatibleTextRendering = $True
	$btn_G4U.UseVisualStyleBackColor = $True
	$btn_G4U.add_Click($btn_G4U_Click)
	#
	# btn_Search_Games
	#
	$btn_Search_Games.Location = '24, 386'
	$btn_Search_Games.Margin = '4, 4, 4, 4'
	$btn_Search_Games.Name = 'btn_Search_Games'
	$btn_Search_Games.Size = '148, 30'
	$btn_Search_Games.TabIndex = 102
	$btn_Search_Games.Text = 'Search'
	$btn_Search_Games.UseCompatibleTextRendering = $True
	$btn_Search_Games.UseVisualStyleBackColor = $True
	$btn_Search_Games.add_Click($btn_Search_Games_Click)
	#
	# progressbar1_Games
	#
	$progressbar1_Games.Location = '24, 452'
	$progressbar1_Games.Margin = '4, 4, 4, 4'
	$progressbar1_Games.Name = 'progressbar1_Games'
	$progressbar1_Games.Size = '816, 30'
	$progressbar1_Games.TabIndex = 105
	#
	# btn_Reset_Games
	#
	$btn_Reset_Games.Location = '595, 328'
	$btn_Reset_Games.Margin = '4, 4, 4, 4'
	$btn_Reset_Games.Name = 'btn_Reset_Games'
	$btn_Reset_Games.Size = '226, 30'
	$btn_Reset_Games.TabIndex = 104
	$btn_Reset_Games.Text = 'Reset Search'
	$btn_Reset_Games.UseCompatibleTextRendering = $True
	$btn_Reset_Games.UseVisualStyleBackColor = $True
	$btn_Reset_Games.add_Click($btn_Reset_Games_Click)
	#
	# searchRls_Games
	#
	$searchRls_Games.AccessibleName = ''
	$searchRls_Games.Location = '24, 355'
	$searchRls_Games.Margin = '4, 4, 4, 4'
	$searchRls_Games.Name = 'searchRls_Games'
	$searchRls_Games.Size = '387, 23'
	$searchRls_Games.TabIndex = 101
	#
	# btn_Go_Games
	#
	$btn_Go_Games.Location = '707, 507'
	$btn_Go_Games.Margin = '4, 4, 4, 4'
	$btn_Go_Games.Name = 'btn_Go_Games'
	$btn_Go_Games.Size = '133, 30'
	$btn_Go_Games.TabIndex = 103
	$btn_Go_Games.Text = '&Go for that shit'
	$btn_Go_Games.UseCompatibleTextRendering = $True
	$btn_Go_Games.UseVisualStyleBackColor = $True
	$btn_Go_Games.add_Click($btn_Go_Games_Click)
	#
	# listboxTopRls_Games
	#
	$listboxTopRls_Games.FormattingEnabled = $True
	$listboxTopRls_Games.ItemHeight = 17
	$listboxTopRls_Games.Location = '24, 12'
	$listboxTopRls_Games.Margin = '4, 4, 4, 4'
	$listboxTopRls_Games.Name = 'listboxTopRls_Games'
	$listboxTopRls_Games.Size = '529, 310'
	$listboxTopRls_Games.TabIndex = 41
	$listboxTopRls_Games.TabStop = $False
	#
	# tooltip1
	#
	$tabpage4.ResumeLayout()
	$tabpage1.ResumeLayout()
	$tabcontrol1.ResumeLayout()
	$formRockysULtimateDLFind.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formRockysULtimateDLFind.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formRockysULtimateDLFind.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formRockysULtimateDLFind.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$formRockysULtimateDLFind.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $formRockysULtimateDLFind.ShowDialog()

}
#endregion Source: MainForm.psf

#Start the application
Main ($CommandLine)
