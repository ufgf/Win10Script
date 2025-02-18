##########
# Win 10 Setup Script/Tweaks with Menu(GUI)
#
# Modded Script + Menu(GUI) By
#  Author: Madbomb122
# Website: https://GitHub.com/Madbomb122/Win10Script/
#
# Original Basic Script By
#  Author: Disassembler0
# Website: https://GitHub.com/Disassembler0/Win10-Initial-Setup-Script/
# Version: 2.0, 2017-01-08 (Version Copied)
#
$Script_Version = '3.6.9'
$Script_Date = 'Feb-25-2019'
$Release_Type = 'Stable'
##########

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!             SAFE TO EDIT ITEM              !!
## !!            AT BOTTOM OF SCRIPT             !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!                  CAUTION                   !!
## !!        DO NOT EDIT PAST THIS POINT         !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<#------------------------------------------------------------------------------#>

$Copyright =' The MIT License (MIT)                                                  
                                                                        
 Copyright (c) 2017 Disassembler                                        
        -Original Basic Version of Script                               
                                                                        
 Copyright (c) 2017-2019 Madbomb122                                     
        -Modded + Menu Version of Script                                
                                                                        
 Permission is hereby granted, free of charge, to any person obtaining  
 a copy of this software and associated documentation files (the        
 "Software"), to deal in the Software without restriction, including    
 without limitation the rights to use, copy, modify, merge, publish,    
 distribute, sublicense, and/or sell copies of the Software, and to     
 permit persons to whom the Software is furnished to do so, subject to  
 the following conditions:                                              
                                                                        
 The above copyright notice(s), this permission notice shall be         
 included in all copies or substantial portions of the Software.        
                                                                        
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY  
 KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR    
 PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS 
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR   
 OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE  
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.     
                                                            '

<#--------------------------------------------------------------------------------

.Prerequisite to run script
  System: Windows 10
  Files: This script

.DESCRIPTION
  Makes it easier to setup an existing or new install with moded setting

.BASIC USAGE
  Use the Menu and set what you want then Click Run the Script

.ADVANCED USAGE
 One of the following Methods...
  1. Edit values at bottom of the script
  2. Edit bat file and run
  3. Run the script with one of these switches (space between multiple)


  Switch          Description of Switch
-- Basic Switches --
  -atos           Accepts ToS
  -auto           Implies -Atos...Closes on - User Errors, or End of Script
  -crp            Creates Restore Point
  -dnr            Do Not Restart when done

-- Run Script Switches --
  -run            Runs script with settings in script
  -run FILENME    Runs script with settings in the file FILENME
  -run wd         Runs script with win default settings

-- Load Script Switches --
  -load FILENME   Loads script with settings in the file FILENME
  -load wd        Loads script with win default settings

--Update Switches--
  -usc            Checks for Update to Script file before running
  -sic            Skips Internet Check

------------------------------------------------------------------------------#>
##########
# Pre-Script -Start
##########

If([Environment]::OSVersion.Version.Major -ne 10) {
	Clear-Host
	Write-Host 'Sorry, this Script supports Windows 10 ONLY.' -ForegroundColor 'cyan' -BackgroundColor 'black'
	If($Automated -ne 1){ Read-Host -Prompt "`nPress Any key to Close..." } ;Exit
}

If($Release_Type -eq 'Stable'){ $ErrorActionPreference = 'SilentlyContinue' } Else{ $Release_Type = 'Testing' }

$Script:PassedArg = $args
$Script:FileBase = $PSScriptRoot + '\'

If(!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PassedArg" -Verb RunAs ;Exit
}

$URL_Base = 'https://raw.GitHub.com/madbomb122/Win10Script/master/'
$Version_Url = $URL_Base + 'Version/Version.csv'
$Donate_Url = 'https://www.amazon.com/gp/registry/wishlist/YBAYWBJES5DE/'
$MySite = 'https://GitHub.com/madbomb122/Win10Script'

#$Script:BuildVer = [Environment]::OSVersion.Version.build
$Script:Win10Ver = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseID).ReleaseId
If([System.Environment]::Is64BitProcess){ $Script:OSBit = 64 } Else{ $Script:OSBit = 32 }

##########
# Pre-Script -End
##########
# Needed Variable -Start
##########

$AppsList = @(
'Microsoft.3DBuilder',
'Microsoft.Microsoft3DViewer',
'Microsoft.BingWeather',
'Microsoft.CommsPhone',
'Microsoft.windowscommunicationsapps',
'Microsoft.GetHelp',
'Microsoft.Getstarted',
'Microsoft.Messaging',
'Microsoft.MicrosoftOfficeHub',
'Microsoft.MovieMoments',
'4DF9E0F8.Netflix',
'Microsoft.Office.OneNote',
'Microsoft.Office.Sway',
'Microsoft.OneConnect',
'Microsoft.People',
'Microsoft.Windows.Photos',
'Microsoft.SkypeApp',
'Microsoft.SkypeWiFi',
'Microsoft.MicrosoftSolitaireCollection',
'Microsoft.MicrosoftStickyNotes',
'Microsoft.WindowsSoundRecorder',
'Microsoft.WindowsAlarms',
'Microsoft.WindowsCalculator',
'Microsoft.WindowsCamera',
'Microsoft.WindowsFeedback',
'Microsoft.WindowsFeedbackHub',
'Microsoft.WindowsMaps',
'Microsoft.WindowsPhone',
'Microsoft.WindowsStore',
'Microsoft.Wallet'
'XboxApps',
'Microsoft.ZuneMusic',
'Microsoft.ZuneVideo')

$TasksList = @(
'Application Experience',
'Consolidator',
'Customer Experience Improvement Program',
'DmClient',
'KernelCeipTask',
'Microsoft Compatibility Appraiser',
'ProgramDataUpdater',
'Proxy',
'QueueReporting',
'SmartScreenSpecific',
'UsbCeip')

<#
'AgentFallBack2016',
'AitAgent',
'CreateObjectTask',
#'Diagnostics',
'DmClientOnScenarioDownload',
'FamilySafetyMonitor',
'FamilySafetyRefresh',
'FamilySafetyRefreshTask',
'FamilySafetyUpload',
#'File History (maintenance mode)',
'GatherNetworkInfo',
'MapsUpdateTask',
#'Microsoft-Windows-DiskDiagnosticDataCollector',
'MNO Metadata Parser',
'OfficeTelemetryAgentFallBack',
'OfficeTelemetryAgentLogOn',
'OfficeTelemetryAgentLogOn2016',
'Sqm-Tasks',
#'StartupAppTask',
'Uploader',
'XblGameSaveTask',
'XblGameSaveTaskLogon') #>

$Xbox_Apps = @(
'Microsoft.XboxApp',
'Microsoft.XboxIdentityProvider',
'Microsoft.XboxSpeechToTextOverlay',
'Microsoft.XboxGameOverlay',
'Microsoft.Xbox.TCUI')

$colors = @(
'black',      #0
'blue',       #1
'cyan',       #2
'darkblue',   #3
'darkcyan',   #4
'darkgray',   #5
'darkgreen',  #6
'darkmagenta',#7
'darkred',    #8
'darkyellow', #9
'gray',       #10
'green',      #11
'magenta',    #12
'red',        #13
'white',      #14
'yellow')     #15

$musnotification_files = @("$Env:windir\System32\musnotification.exe","$Env:windir\System32\musnotificationux.exe")

$MLine = '|'.PadRight(53,'-') + '|'
$MBLine = '|'.PadRight(53) + '|'

Function MenuBlankLine{ DisplayOut DisplayOut $MBLine -C 14 }
Function MenuLine{ DisplayOut DisplayOut $MLine -C 14 }

Function BoxItem([String]$TxtToDisplay) {
	$TLen = $TxtToDisplay.Length
	$LLen = $TLen+9
	DisplayOut "`n".PadRight($LLen,'-') -C 14
	DisplayOut '-',"   $TxtToDisplay   ",'-' -C 14,6,14
	DisplayOut ''.PadRight($LLen-1,'-') -C 14
}

Function AnyKeyClose{ Read-Host -Prompt "`nPress Any key to Close..." }

##########
# Needed Variable -End
##########
# Update Functions -Start
##########

Function UpdateCheck {
	If(InternetCheck) {
		$CSV_Ver = Invoke-WebRequest $Version_Url | ConvertFrom-Csv
		If($Release_Type -eq 'Stable'){ $CSVLine = 0 ;$RT = '' } Else{ $CSVLine = 1 ;$RT = 'Testing/' }
		$WebScriptVer = $CSV_Ver[$CSVLine].Version + "." + $CSV_Ver[$CSVLine].MinorVersion
		If($WebScriptVer -gt $Script_Version){ ScriptUpdateFun $RT }
	} Else {
		Clear-Host
		MenuLine
		DisplayOutLML (''.PadRight(22)+'Error') -C 13
		MenuLine
		MenuBlankLine
		DisplayOutLML 'No Internet connection detected or GitHub.com' -C 2
		DisplayOutLML 'is currently down.' -C 2
		DisplayOutLML 'Tested by pinging GitHub.com' -C 2
		MenuBlankLine
		DisplayOutLML 'To skip use one of the following methods' -C 2
		DisplayOut '|',' 1. Change ','InternetCheck',' in bat file'.PadRight(28),'|' -C 14,2,15,2,14
		DisplayOut '|',' 2. Change ','InternetCheck',' in bat file'.PadRight(28),'|' -C 14,2,15,2,14
		DisplayOut '|',' 3. Run Script or Bat file with ','-sic',' switch         ','|' -C 14,2,15,2,14
		MenuBlankLine
		MenuLine
		AnyKeyClose
	}
}

Function ScriptUpdateFun([String]$RT) {
	$Script_Url = $URL_Base + $RT + 'Win10-Menu.ps1'
	$ScrpFilePath = $FileBase + 'Win10-Menu.ps1'
	$FullVer = "$WebScriptVer.$WebScriptMinorVer"
	$UpArg = ''

	If($Accept_ToS -ne 1){ $UpArg += '-atos ' }
	If($InternetCheck -eq 1){ $UpArg += '-sic ' }
	If($CreateRestorePoint -eq 1){ $UpArg += '-crp ' }
	If($Restart -eq 0){ $UpArg += '-dnr' }
	If($RunScr){ $UpArg += "-run $TempSetting " } Else{ $UpArg += "-load $TempSetting " }

	Clear-Host
	MenuLine -L
	MenuBlankLine -L
	DisplayOutLML (''.PadRight(18)+'Update Found!') -C 13 -L
	MenuBlankLine -L
	DisplayOut '|',' Updating from version ',"$Script_Version".PadRight(30),'|' -C 14,15,11,14 -L
	MenuBlankLine -L
	DisplayOut '|',' Downloading version ',"$FullVer".PadRight(31),'|' -C 14,15,11,14 -L
	DisplayOutLML 'Will run after download is complete.' -C 15 -L
	MenuBlankLine -L
	MenuLine -L

	(New-Object System.Net.WebClient).DownloadFile($Script_Url, $ScrpFilePath)
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$ScrpFilePath`" $UpArg" -Verb RunAs
	Exit
}

Function InternetCheck{ If($InternetCheck -eq 1 -or (Test-Connection www.GitHub.com -Count 1 -Quiet)){ Return $True } Return $False }

##########
# Update Functions -End
##########
# Multi Use Functions -Start
##########

Function ThanksDonate {
	DisplayOut "`nThanks for using my script." -C 11
	DisplayOut 'If you like this script please consider giving me a donation.' -C 11
	DisplayOut "`nLink to donation:" -C 15
	DisplayOut $Donate_Url -C 2
}

Function cmpv{ Compare-Object (Get-Variable -Scope Script) $AutomaticVariables -Property Name -PassThru | Where-Object -Property Name -ne 'AutomaticVariables' | Where-Object { $_ -NotIn $WPFList } }
Function Openwebsite([String]$Url){ [System.Diagnostics.Process]::Start($Url) }
Function ShowInvalid([Int]$InvalidA){ If($InvalidA -eq 1){ Write-Host "`nInvalid Input" -ForegroundColor Red -BackgroundColor Black -NoNewline } Return 0 }
Function CheckSetPath([String]$RPath){ While(!(Test-Path $RPath)){ New-Item -Path $RPath -Force | Out-Null } Return $RPath }
Function RemoveSetPath([String]$RPath){ If(Test-Path $RPath){ Remove-Item -Path $RPath -Recurse } }
Function StartOrGui{ If($RunScr -eq $True){ RunScript } ElseIf($AcceptToS -ne 1){ GuiStart } }

Function DisplayOut {
	Param (	[alias ("T")] [String[]]$Text, [alias ("C")] [Int[]]$Color )
	For($i=0 ;$i -lt $Text.Length ;$i++){ Write-Host $Text[$i] -ForegroundColor $colors[$Color[$i]] -BackgroundColor 'Black' -NoNewLine } ;Write-Host
}

Function DisplayOutLML([String]$Text,[Alias ("C")] [Int]$Color) {
	DisplayOut '| ',"$Text".PadRight(50),' |' -C 14,$Color,14 -L:$Log
}

Function ScriptPreStart {
	SetDefault
	If($PassedArg.Length -gt 0){ ArgCheck }
	If($AcceptToS -eq 1){ TOS } Else{ StartOrGui }
}

Function PassVal([String]$Pass){ Return $PassedArg[$PassedArg.IndexOf($Pass)+1] }
Function ArgCheck {
	If($PassedArg -In '-help','-h'){ ShowHelp }
	If($PassedArg -Contains '-copy'){ ShowCopyright ;Exit }
	If($PassedArg -Contains '-run') {
		$tmp = PassVal '-run'
		If(Test-Path -LiteralPath $tmp -PathType Leaf) {
			LoadSettingFile $tmp ;$Script:RunScr = $True
		} ElseIf($tmp -In 'wd','windefault') {
			LoadWinDefault ;$Script:RunScr = $True
		} ElseIf($tmp.StartsWith('-') -or $PassedArg.IndexOf('-run') -eq  $PassedArg.Length) {
			$Script:RunScr = $True
		}
	}
	If($PassedArg -Contains '-load') {
		$tmp = PassVal '-load'
		If(Test-Path -LiteralPath $tmp -PathType Leaf){ LoadSettingFile $tmp } ElseIf($tmp -In 'wd','windefault'){ LoadWinDefault }
	}
	If($PassedArg -Contains '-sic'){ $Script:InternetCheck = 1 }
	If($PassedArg -Contains '-usc'){ $Script:VersionCheck  = 1 }
	If($PassedArg -Contains '-atos'){ $Script:AcceptToS = 'Accepted' }
	If($PassedArg -Contains '-dnr'){ $Script:Restart = 0 }
	If($PassedArg -Contains '-auto'){ $Script:Automated = 1 ;$Script:AcceptToS = 'Accepted' }
	If($PassedArg -Contains '-crp') {
		$Script:CreateRestorePoint = 1
		$tmp = PassVal '-crp'
		If(!$tmp.StartsWith('-')){ $Script:RestorePointName = $tmp }
	}
}

Function ShowHelp {
	Clear-Host
	DisplayOut '             List of Switches' -C 13
	DisplayOut ''.PadRight(53,'-') -C 14
	DisplayOut ' Switch ',"Description of Switch`n".PadLeft(31) -C 14,15
	DisplayOut '-- Basic Switches --' -C 2
	DisplayOut '  -atos ','           Accepts ToS' -C 14,15
	DisplayOut '  -auto ','           Implies ','-atos','...Runs the script to be Automated.. Closes on - User Input, Errors, or End of Script' -C 14,15,14,15
	DisplayOut '  -crp  ','           Creates Restore Point' -C 14,15
	DisplayOut '  -dnr  ','           Do Not Restart when done' -C 14,15
	DisplayOut "`n-- Run Script Switches --" -C 2
	DisplayOut '  -run  ','           Runs script with settings in script' -C 14,15
	DisplayOut '  -run  ','FILENAME ','   Runs script with settings in the file',' FILENAME' -C 14,11,15,11
	DisplayOut '  -run wd ','         Runs script with win default settings' -C 14,15
	DisplayOut "`n-- Load Script Switches --" -C 2
	DisplayOut '  -run  ','FILENAME ','  Loads script with settings in the file',' FILENAME' -C 14,11,15,11
	DisplayOut '  -load wd ','        Loads script with win default settings' -C 14,15
	DisplayOut "`n--Update Switches--" -C 2
	DisplayOut '  -usc ','            Checks for Update to Script file before running' -C 14,15
	DisplayOut '  -sic ',"            Skips Internet Check, if you can't ping GitHub.com for some reason" -C 14,15
	DisplayOut "`n--Help--" -C 2
	DisplayOut '  -help ','           Shows list of switches, then exits script.. alt ','-h' -C 14,15,14
	DisplayOut '  -copy ','           Shows Copyright/License Information, then exits script' -C 14,15
	AnyKeyClose
	Exit
}

Function TOSLine([Int]$BC){ DisplayOut $MLine -C $BC}
Function TOSBlankLine([Int]$BC){ DisplayOut $MBLine -C $BC }
Function ShowCopyright { Clear-Host ;DisplayOut $Copyright -C 14 }

Function TOSDisplay([Switch]$C) {
	If(!$C){ Clear-Host }
	$BorderColor = 14
	If($Release_Type -ne 'Stable') {
		$BorderColor = 15
		TOSLine 15
		DisplayOut '|'.PadRight(22),'Caution!!!'.PadRight(31),'|' -C 15,13,15
		TOSBlankLine 15
		DisplayOut '|','         This script is still being tested.         ','|' -C 15,14,15
		DisplayOut '|'.PadRight(17),'USE AT YOUR OWN RISK.'.PadRight(36),'|' -C 15,14,15
		TOSBlankLine 15
	}
	TOSLine $BorderColor
	DisplayOut '|'.PadRight(21),'Terms of Use'.PadRight(32),'|' -C $BorderColor,11,$BorderColor
	TOSLine $BorderColor
	TOSBlankLine $BorderColor
	DisplayOut '|',' This program comes with ABSOLUTELY NO WARRANTY.    ','|' -C $BorderColor,2,$BorderColor
	DisplayOut '|',' This is free software, and you are welcome to      ','|' -C $BorderColor,2,$BorderColor
	DisplayOut '|',' redistribute it under certain conditions.'.PadRight(52),'|' -C $BorderColor,2,$BorderColor
	TOSBlankLine $BorderColor
	DisplayOut '|',' Read License file for full Terms.'.PadRight(52),'|' -C $BorderColor,2,$BorderColor
	TOSBlankLine $BorderColor
	DisplayOut '|',' Use the switch ','-copy',' to see License Information or ','|' -C $BorderColor,2,14,2,$BorderColor
	DisplayOut '|',' enter ','L',' bellow.'.PadRight(44),'|' -C $BorderColor,2,14,2,$BorderColor
	TOSBlankLine $BorderColor
	TOSLine $BorderColor
}

Function TOS {
	$CopyR = $False
	While($TOS -ne 'Out') {
		TOSDisplay -c:$CopyR
		$CopyR = $False
		$Invalid = ShowInvalid $Invalid
		$TOS = Read-Host "`nDo you Accept? (Y)es/(N)o"
		If($TOS.ToLower() -In 'n','no'){
			Exit
		} ElseIf($TOS -In 'y','yes') {
			$Script:AcceptToS = 'Accepted-Script' ;$TOS = 'Out' ;StartOrGui
		} ElseIf($TOS -eq 'l') {
			$CopyR = $True ;ShowCopyright
		} Else {
			$Invalid = 1
		}
	} Return
}

Function LoadSettingFile([String]$Filename) {
	(Import-Csv -LiteralPath $Filename -Delimiter ';').ForEach{ Set-Variable $_.Name $_.Value -Scope Script }
	[System.Collections.ArrayList]$Script:APPS_AppsUnhide = $AppsUnhide.Split(',')
	[System.Collections.ArrayList]$Script:APPS_AppsHidel = $AppsHide.Split(',')
	[System.Collections.ArrayList]$Script:APPS_AppsUninstall = $AppsUninstall.Split(',')
}

Function SaveSettingFiles([String]$Filename) {
	ForEach($temp In $APPS_AppsUnhide){$Script:AppsUnhide += $temp + ','}
	ForEach($temp In $APPS_AppsHide){$Script:AppsHide += $temp + ','}
	ForEach($temp In $APPS_Uninstall){$Script:AppsUninstall += $temp + ','}
	If(Test-Path -LiteralPath $Filename -PathType Leaf) {
		If($ShowConf -eq 1){ $Conf = ConfirmMenu 2 } Else{ $Conf = $True }
		If($Conf){ cmpv | Select-Object Name,Value | Export-Csv -LiteralPath $Filename -Encoding 'unicode' -Force -Delimiter ';' }
	} Else {
		cmpv | Select-Object Name,Value | Export-Csv -LiteralPath $Filename -Encoding 'unicode' -Force -Delimiter ';'
	}
}

##########
# Multi Use Functions -End
##########
# GUI -Start
##########

Function SetCombo([String]$Name,[String]$Item) {
	$Items = $Item.Split(',')
	$combo =  $(Get-Variable -Name ('WPF_'+$Name+'_Combo') -ValueOnly)
	[Void] $combo.Items.Add('Skip')
	ForEach($CmbItm In $Items){ [void] $combo.Items.Add($CmbItm) }
	SelectComboBoxGen $Name $(Get-Variable -Name $Name -ValueOnly)
}

Function SetComboM([String]$Name,[String]$Item) {
	$Items = $Item.Split(',')
	$combo =  $(Get-Variable -Name ('WPF_'+$Name+'_Combo') -ValueOnly)
	[Void] $combo.Items.Add('Skip')
	ForEach($CmbItm In $Items){ [Void] $combo.Items.Add($CmbItm) }
	If($Name -eq 'AllMetro') {
		$WPF_AllMetro_Combo.SelectedIndex = 0
	} ElseIf($Name -eq 'APP_SkypeApp') {
		$WPF_APP_SkypeApp_Combo.SelectedIndex = $APP_SkypeApp1
	} ElseIf($Name -eq 'APP_WindowsFeedbak') {
		$WPF_APP_WindowsFeedbak_Combo.SelectedIndex = $APP_WindowsFeedbak1
	} ElseIf($Name -eq 'APP_Zune') {
		$WPF_APP_Zune_Combo.SelectedIndex = $APP_ZuneMusic
	} Else {
		SelectComboBoxGen $Name $(Get-Variable -Name $Name -ValueOnly)
	}
}

Function RestorePointCBCheck {
	If($CreateRestorePoint -eq 1) {
		$WPF_CreateRestorePoint_CB.IsChecked = $True
		$WPF_RestorePointName_Txt.IsEnabled = $True
	} Else {
		$WPF_CreateRestorePoint_CB.IsChecked = $False
		$WPF_RestorePointName_Txt.IsEnabled = $False
	}
}

Function ConfigGUIitms {
	If($CreateRestorePoint -eq 1){ $WPF_CreateRestorePoint_CB.IsChecked = $True } Else{ $WPF_CreateRestorePoint_CB.IsChecked = $False }
	If($VersionCheck -eq 1){ $WPF_VersionCheck_CB.IsChecked = $True } Else{ $WPF_VersionCheck_CB.IsChecked = $False }
	If($InternetCheck -eq 1){ $WPF_InternetCheck_CB.IsChecked = $True } Else{ $WPF_InternetCheck_CB.IsChecked = $False }
	If($ShowSkipped -eq 1){ $WPF_ShowSkipped_CB.IsChecked = $True } Else{ $WPF_ShowSkipped_CB.IsChecked = $False }
	If($Restart -eq 1){ $WPF_Restart_CB.IsChecked = $True } Else{ $WPF_Restart_CB.IsChecked = $False }
	$WPF_RestorePointName_Txt.Text = $RestorePointName
	RestorePointCBCheck
}

Function SelectComboBox([Array]$List,[Int]$Metro) {
	If($Metro -eq 1) {
		ForEach($Var In $List) {
			If($Var -eq 'APP_SkypeApp') {
				$WPF_APP_SkypeApp_Combo.SelectedIndex = $APP_SkypeApp1
			} ElseIf($Var -eq 'APP_WindowsFeedbak') {
				$WPF_APP_WindowsFeedbak_Combo.SelectedIndex = $APP_WindowsFeedbak1
			} ElseIf($Var -eq 'APP_Zune') {
				$WPF_APP_Zune_Combo.SelectedIndex = $APP_ZuneMusic
			} Else {
				SelectComboBoxGen $Var $(Get-Variable -Name $Var -ValueOnly)
			}
		}
	} Else{ ForEach($Var In $List){ SelectComboBoxGen $Var $(Get-Variable -Name $Var -ValueOnly) } }
}
Function SelectComboBoxAllMetro([Int]$Numb){ ForEach($Var In $ListApp){ SelectComboBoxGen $Var $Numb } }
Function SelectComboBoxGen([String]$Name,[Int]$Numb){ $(Get-Variable -Name ('WPF_'+$Name+'_Combo') -ValueOnly).SelectedIndex = $Numb }

Function AppAraySet([String]$Get) {
	[System.Collections.ArrayList]$ListTMP = Get-Variable -Name $Get
	[System.Collections.ArrayList]$List = @()
	If($Get -eq 'WPF_*_Combo'){
		ForEach($Var In $ListTMP){ If($Var.Name -NotLike 'WPF_APP_*'){ $List += $Var.Name.Split('_')[1] } }
		$List.Remove('AllMetro')
	} Else {
		ForEach($Var In $ListTMP){ $List += $Var.Name }
		$List.Remove('APP_SkypeApp1')
		$List.Remove('APP_SkypeApp2')
		$List.Remove('APP_WindowsFeedbak1')
		$List.Remove('APP_WindowsFeedbak2')
		$List.Remove('APP_ZuneMusic')
		$List.Remove('APP_ZuneVideo')
		[Void] $List.Add('APP_SkypeApp')
		[Void] $List.Add('APP_WindowsFeedbak')
		[Void] $List.Add('APP_Zune')
	} Return $List
}

Function OpenSaveDiaglog([Int]$SorO) {
	If($SorO -eq 0){ $SOFileDialog = New-Object System.Windows.Forms.OpenFileDialog } Else{ $SOFileDialog = New-Object System.Windows.Forms.SaveFileDialog }
	$SOFileDialog.InitialDirectory = $FileBase
	$SOFileDialog.Filter = "CSV (*.csv)| *.csv"
	$SOFileDialog.ShowDialog() | Out-Null
	If($SorO -eq 0){ LoadSettingFile $SOFileDialog.Filename ;ConfigGUIitms ;SelectComboBox $VarList 0 ;SelectComboBox $ListApp 1 } Else{ GuiItmToVariable ;SaveSettingFiles $SOFileDialog.Filename }
}

Function GuiStart {
	Clear-Host
	DisplayOut 'Preparing GUI, Please wait...' -C 15

[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" x:Name="Win10_Script"
Title="Windows 10 Settings/Tweaks Script By: Madbomb122 (v.$Script_Version -$Script_Date" Height="405" Width="550" BorderBrush="Black" Background="White">
	<Window.Resources>
		<Style x:Key="SeparatorStyle1" TargetType="{x:Type Separator}">
			<Setter Property="SnapsToDevicePixels" Value="True"/>
			<Setter Property="Margin" Value="0,0,0,0"/>
			<Setter Property="Template">
				<Setter.Value> <ControlTemplate TargetType="{x:Type Separator}"><Border Height="24" SnapsToDevicePixels="True" Background="#FF4D4D4D" BorderBrush="#FF4D4D4D" BorderThickness="0,0,0,1"/></ControlTemplate></Setter.Value>
			</Setter>
		</Style>
		<Style TargetType="{x:Type ToolTip}"><Setter Property="Background" Value="#FFFFFFBF"/></Style>
	</Window.Resources>
	<Window.Effect><DropShadowEffect/></Window.Effect>
	<Grid>
		<Menu Height="22" VerticalAlignment="Top">
			<MenuItem Header="Help" Height="22" Width="34" Padding="3,0,0,0">
				<MenuItem Name="FeedbackButton" Header="Feedback/Bug Report" Height="22" Background="#FFF0F0F0" Padding="-20,0,-40,0"/>
				<MenuItem Name="FAQButton" Header="FAQ" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/>
				<MenuItem Name="AboutButton" Header="About" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/>
				<MenuItem Name="CopyrightButton" Header="Copyright" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/><Separator Height="2" Margin="-30,0,0,0"/>
				<MenuItem Name="ContactButton" Header="Contact Me" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/>
			</MenuItem>
			<Separator Width="2" Style="{DynamicResource SeparatorStyle1}"/>
			<MenuItem Name="DonateButton" Header="Donate to Me" Height="24" Width="88" Background="#FFFFAD2F" FontWeight="Bold" Margin="-1,-1,0,0"/>
			<MenuItem Name="Madbomb122WSButton" Header="Madbomb122's GitHub" Height="24" Width="142" Background="#FFFFDF4F" FontWeight="Bold"/>
		</Menu>
		<TabControl Name="TabControl" Margin="0,22,0,21">
			<TabItem Name="Services_Tab" Header="Script Options" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<CheckBox Name="CreateRestorePoint_CB" Content="Create Restore Point:" HorizontalAlignment="Left" Margin="8,10,0,0" VerticalAlignment="Top"/>
					<TextBox Name="RestorePointName_Txt" HorizontalAlignment="Left" Height="20" Margin="139,9,0,0" TextWrapping="Wrap" Text="Win10 Initial Setup Script" VerticalAlignment="Top" Width="188"/>
					<CheckBox Name="ShowSkipped_CB" Content="Show Skipped Items" HorizontalAlignment="Left" Margin="8,29,0,0" VerticalAlignment="Top"/>
					<CheckBox Name="Restart_CB" Content="Restart When Done (Restart is Recommended)" HorizontalAlignment="Left" Margin="8,49,0,0" VerticalAlignment="Top"/>
					<CheckBox Name="VersionCheck_CB" Content="Check for Update (If update found, will run and use current settings)" HorizontalAlignment="Left" Margin="8,69,0,0" VerticalAlignment="Top"/>
					<CheckBox Name="InternetCheck_CB" Content="Skip Internet Check" HorizontalAlignment="Left" Margin="8,89,0,0" VerticalAlignment="Top"/>
					<Button Name="Save_Setting_Button" Content="Save Settings" HorizontalAlignment="Left" Margin="100,113,0,0" VerticalAlignment="Top" Width="77"/>
					<Button Name="Load_Setting_Button" Content="Load Settings" HorizontalAlignment="Left" Margin="8,113,0,0" VerticalAlignment="Top" Width="77"/>
					<Button Name="WinDefault_Button" Content="Windows Default*" HorizontalAlignment="Left" Margin="192,113,0,0" VerticalAlignment="Top" Width="100"/>
					<Button Name="ResetDefault_Button" Content="Reset All Items" HorizontalAlignment="Left" Margin="306,113,0,0" VerticalAlignment="Top" Width="85"/>
					<Label Content="Notes:&#xD;&#xA;Options with items marked with * means &quot;Windows Default&quot;&#xA;Windows Default Button does not change Metro Apps or OneDrive Install" HorizontalAlignment="Left" Margin="8,141,0,0" VerticalAlignment="Top" FontStyle="Italic"/>
					<Label Content="Script Version:" HorizontalAlignment="Left" Margin="8,199,0,0" VerticalAlignment="Top" Height="25"/>
					<TextBox Name="Script_Ver_Txt" HorizontalAlignment="Left" Height="20" Margin="90,203,0,0" TextWrapping="Wrap" Text="$Script_Version ($Script_Date)" VerticalAlignment="Top" Width="124" IsEnabled="False"/>
					<TextBox Name="Release_Type_Txt" HorizontalAlignment="Left" Height="20" Margin="214,203,0,0" TextWrapping="Wrap" Text="$Release_Type" VerticalAlignment="Top" Width="50" IsEnabled="False"/>
				</Grid>
			</TabItem>
			<TabItem Name="Privacy_tab" Header="Privacy" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Telemetry:" HorizontalAlignment="Left" Margin="67,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Telemetry_Combo" HorizontalAlignment="Left" Margin="128,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Wi-Fi Sense:" HorizontalAlignment="Left" Margin="57,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WiFiSense_Combo" HorizontalAlignment="Left" Margin="128,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="SmartScreen Filter:" HorizontalAlignment="Left" Margin="21,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SmartScreen_Combo" HorizontalAlignment="Left" Margin="127,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Location Tracking:" HorizontalAlignment="Left" Margin="25,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LocationTracking_Combo" HorizontalAlignment="Left" Margin="127,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Feedback:" HorizontalAlignment="Left" Margin="67,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Feedback_Combo" HorizontalAlignment="Left" Margin="127,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Advertising ID:" HorizontalAlignment="Left" Margin="43,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AdvertisingID_Combo" HorizontalAlignment="Left" Margin="127,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Cortana:" HorizontalAlignment="Left" Margin="341,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Cortana_Combo" HorizontalAlignment="Left" Margin="392,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Cortana Search:" HorizontalAlignment="Left" Margin="302,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CortanaSearch_Combo" HorizontalAlignment="Left" Margin="392,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Error Reporting:" HorizontalAlignment="Left" Margin="301,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ErrorReporting_Combo" HorizontalAlignment="Left" Margin="392,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="AutoLogger:" HorizontalAlignment="Left" Margin="320,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AutoLoggerFile_Combo" HorizontalAlignment="Left" Margin="392,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Diagnostics Tracking:" HorizontalAlignment="Left" Margin="274,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="DiagTrack_Combo" HorizontalAlignment="Left" Margin="392,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="WAP Push:" HorizontalAlignment="Left" Margin="329,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WAPPush_Combo" HorizontalAlignment="Left" Margin="392,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="App Auto Download:" HorizontalAlignment="Left" Margin="274,172,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AppAutoDownload_Combo" HorizontalAlignment="Left" Margin="392,175,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="SrvTweak_Tab" Header="Service Tweaks" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="UAC Level:" HorizontalAlignment="Left" Margin="79,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UAC_Combo" HorizontalAlignment="Left" Margin="142,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Sharing mapped drives:" HorizontalAlignment="Left" Margin="10,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SharingMappedDrives_Combo" HorizontalAlignment="Left" Margin="142,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Administrative Shares:" HorizontalAlignment="Left" Margin="18,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AdminShares_Combo" HorizontalAlignment="Left" Margin="142,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Firewall:" HorizontalAlignment="Left" Margin="93,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Firewall_Combo" HorizontalAlignment="Left" Margin="142,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Windows Defender:" HorizontalAlignment="Left" Margin="31,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinDefender_Combo" HorizontalAlignment="Left" Margin="142,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="HomeGroups:" HorizontalAlignment="Left" Margin="62,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="HomeGroups_Combo" HorizontalAlignment="Left" Margin="142,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Remote Assistance:" HorizontalAlignment="Left" Margin="34,172,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RemoteAssistance_Combo" HorizontalAlignment="Left" Margin="142,175,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Remote Desktop w/o &#xD;&#xA;Network Authentication:" HorizontalAlignment="Left" Margin="7,196,0,0" VerticalAlignment="Top" Width="138" Height="39"/>
					<ComboBox Name="RemoteDesktop_Combo" HorizontalAlignment="Left" Margin="142,205,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="Context_Tab" Header="Context Menu/Start Menu" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Context Menu" HorizontalAlignment="Left" Margin="82,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Cast to Device:" HorizontalAlignment="Left" Margin="43,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CastToDevice_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Previous Versions:" HorizontalAlignment="Left" Margin="26,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PreviousVersions_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Include in Library:" HorizontalAlignment="Left" Margin="28,84,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="IncludeinLibrary_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Pin To Start:" HorizontalAlignment="Left" Margin="59,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PinToStart_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Pin To Quick Access:" HorizontalAlignment="Left" Margin="14,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PinToQuickAccess_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Share With/Share:" HorizontalAlignment="Left" Margin="26,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ShareWith_Combo" HorizontalAlignment="Left" Margin="128,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Send To:" HorizontalAlignment="Left" Margin="76,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SendTo_Combo" HorizontalAlignment="Left" Margin="128,196,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Start Menu" HorizontalAlignment="Left" Margin="352,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="Bing Search in Start Menu:" HorizontalAlignment="Left" Margin="293,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StartMenuWebSearch_Combo" HorizontalAlignment="Left" Margin="439,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Start Suggestions:" HorizontalAlignment="Left" Margin="337,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StartSuggestions_Combo" HorizontalAlignment="Left" Margin="439,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Most Used Apps:" HorizontalAlignment="Left" Margin="342,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="MostUsedAppStartMenu_Combo" HorizontalAlignment="Left" Margin="439,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Recent Items &amp; Frequent Places:" HorizontalAlignment="Left" Margin="262,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RecentItemsFrequent_Combo" HorizontalAlignment="Left" Margin="439,61,0,0" VerticalAlignment="Top" Width="72"/>
                    <Label Content="Unpin All Items:" HorizontalAlignment="Left" Margin="349,139,0,0" VerticalAlignment="Top"/>
                    <ComboBox Name="UnpinItems_Combo" HorizontalAlignment="Left" Margin="439,142,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="TaskBar_Tab" Header="Task Bar" Margin="-3,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Battery UI Bar:" HorizontalAlignment="Left" Margin="61,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="BatteryUIBar_Combo" HorizontalAlignment="Left" Margin="143,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Clock UI Bar:" HorizontalAlignment="Left" Margin="69,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ClockUIBar_Combo" HorizontalAlignment="Left" Margin="143,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Volume Control Bar:" HorizontalAlignment="Left" Margin="277,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="VolumeControlBar_Combo" HorizontalAlignment="Left" Margin="390,121,0,0" VerticalAlignment="Top" Width="120"/>
					<Label Content="Taskbar Search box:" HorizontalAlignment="Left" Margin="33,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarSearchBox_Combo" HorizontalAlignment="Left" Margin="143,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Task View button:" HorizontalAlignment="Left" Margin="44,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskViewButton_Combo" HorizontalAlignment="Left" Margin="143,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar Icon Size:" HorizontalAlignment="Left" Margin="291,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarIconSize_Combo" HorizontalAlignment="Left" Margin="390,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar Item Grouping:" HorizontalAlignment="Left" Margin="260,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarGrouping_Combo" HorizontalAlignment="Left" Margin="390,67,0,0" VerticalAlignment="Top" Width="90"/>
					<Label Content="Tray Icons:" HorizontalAlignment="Left" Margin="328,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TrayIcons_Combo" HorizontalAlignment="Left" Margin="390,13,0,0" VerticalAlignment="Top" Width="97"/>
					<Label Content="Seconds In Clock:" HorizontalAlignment="Left" Margin="44,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SecondsInClock_Combo" HorizontalAlignment="Left" Margin="143,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Last Active Click:" HorizontalAlignment="Left" Margin="49,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LastActiveClick_Combo" HorizontalAlignment="Left" Margin="143,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar on Multi Display:" HorizontalAlignment="Left" Margin="252,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskBarOnMultiDisplay_Combo" HorizontalAlignment="Left" Margin="390,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar Button on Multi Display:" HorizontalAlignment="Left" Margin="13,172,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarButtOnDisplay_Combo" HorizontalAlignment="Left" Margin="190,175,0,0" VerticalAlignment="Top" Width="197"/>
				</Grid>
			</TabItem>
			<TabItem Name="Explorer_Tab" Header="Explorer" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Process ID on Title Bar:" HorizontalAlignment="Left" Margin="308,120,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PidInTitleBar_Combo" HorizontalAlignment="Left" Margin="436,123,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Aero Snap:" HorizontalAlignment="Left" Margin="69,30,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AeroSnap_Combo" HorizontalAlignment="Left" Margin="133,33,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Aero Shake:" HorizontalAlignment="Left" Margin="63,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AeroShake_Combo" HorizontalAlignment="Left" Margin="133,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Known Extensions:" HorizontalAlignment="Left" Margin="331,147,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="KnownExtensions_Combo" HorizontalAlignment="Left" Margin="436,150,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Hidden Files:" HorizontalAlignment="Left" Margin="58,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="HiddenFiles_Combo" HorizontalAlignment="Left" Margin="133,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="System Files:" HorizontalAlignment="Left" Margin="59,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SystemFiles_Combo" HorizontalAlignment="Left" Margin="133,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Default Explorer View:" HorizontalAlignment="Left" Margin="10,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ExplorerOpenLoc_Combo" HorizontalAlignment="Left" Margin="133,196,0,0" VerticalAlignment="Top" Width="102"/>
					<Label Content="Recent Files in Quick Access:" HorizontalAlignment="Left" Margin="279,11,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RecentFileQikAcc_Combo" HorizontalAlignment="Left" Margin="436,14,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Frequent folders in Quick_access:" HorizontalAlignment="Left" Margin="259,39,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="FrequentFoldersQikAcc_Combo" HorizontalAlignment="Left" Margin="436,41,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Window Content while Dragging:" HorizontalAlignment="Left" Margin="253,66,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinContentWhileDrag_Combo" HorizontalAlignment="Left" Margin="436,69,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Autoplay:" HorizontalAlignment="Left" Margin="76,3,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Autoplay_Combo" HorizontalAlignment="Left" Margin="133,6,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Autorun:" HorizontalAlignment="Left" Margin="80,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Autorun_Combo" HorizontalAlignment="Left" Margin="133,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Search Store for Unkn. Extensions:" HorizontalAlignment="Left" Margin="249,94,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StoreOpenWith_Combo" HorizontalAlignment="Left" Margin="436,96,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Task Manager Details:" HorizontalAlignment="Left" Margin="315,175,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskManagerDetails_Combo" HorizontalAlignment="Left" Margin="436,177,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Powershell to Cmd:" HorizontalAlignment="Left" Margin="24,220,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinXPowerShell_Combo" HorizontalAlignment="Left" Margin="133,223,0,0" VerticalAlignment="Top" Width="127"/>
					<Label Name="ReopenAppsOnBoot_Txt" Content="Reopen Apps On Boot:" HorizontalAlignment="Left" Margin="309,203,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ReopenAppsOnBoot_Combo" HorizontalAlignment="Left" Margin="436,205,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Name="TimeLine_Txt" Content="Window Timeline:" HorizontalAlignment="Left" Margin="336,231,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Timeline_Combo" HorizontalAlignment="Left" Margin="436,233,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Long File Path:" HorizontalAlignment="Left" Margin="49,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LongFilePath_Combo" HorizontalAlignment="Left" Margin="133,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="App Hibernation File (Swapfile.sys):" HorizontalAlignment="Left" Margin="6,245,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AppHibernationFile_Combo" HorizontalAlignment="Left" Margin="197,248,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="Desktop_Tab" Header="Desktop/This PC" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Desktop" HorizontalAlignment="Left" Margin="99,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="This PC Icon:" HorizontalAlignment="Left" Margin="54,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ThisPCOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Network Icon:" HorizontalAlignment="Left" Margin="47,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="NetworkOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Recycle Bin Icon:" HorizontalAlignment="Left" Margin="34,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RecycleBinOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Users File Icon:" HorizontalAlignment="Left" Margin="42,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UsersFileOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Control Panel Icon:" HorizontalAlignment="Left" Margin="21,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ControlPanelOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Desktop Folder:" HorizontalAlignment="Left" Margin="302,31,0,0" VerticalAlignment="Top"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="This PC" HorizontalAlignment="Left" Margin="364,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<ComboBox Name="DesktopIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,34,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Documents Folder:" HorizontalAlignment="Left" Margin="285,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="DocumentsIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,61,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Downloads Folder:" HorizontalAlignment="Left" Margin="287,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="DownloadsIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,88,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Music Folder:" HorizontalAlignment="Left" Margin="315,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="MusicIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,115,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Pictures Folder:" HorizontalAlignment="Left" Margin="304,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PicturesIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,142,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Videos Folder:" HorizontalAlignment="Left" Margin="310,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="VideosIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,169,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Name="ThreeDobjectsIconInThisPC_Txt" Content="3D Objects Folder:" HorizontalAlignment="Left" Margin="288,194,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ThreeDobjectsIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,197,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="**Remove may cause problems with a few things" HorizontalAlignment="Left" Margin="255,216,0,0" VerticalAlignment="Top"/>
				</Grid>
			</TabItem>
			<TabItem Name="Misc_Tab" Header="Misc/Photo Viewer/LockScreen" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Misc" HorizontalAlignment="Left" Margin="109,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Action Center:" HorizontalAlignment="Left" Margin="46,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ActionCenter_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Sticky Key Prompt:" HorizontalAlignment="Left" Margin="23,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StickyKeyPrompt_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Num Lock on Startup:" HorizontalAlignment="Left" Margin="6,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="NumblockOnStart_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="F8 Boot Menu:" HorizontalAlignment="Left" Margin="44,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="F8BootMenu_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Remote UAC Local &#xD;&#xA;Account Token Filter:" HorizontalAlignment="Left" Margin="11,187,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RemoteUACAcctToken_Combo" HorizontalAlignment="Left" Margin="128,197,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Hibernate Option:" HorizontalAlignment="Left" Margin="26,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="HibernatePower_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Sleep Option:" HorizontalAlignment="Left" Margin="49,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SleepPower_Combo" HorizontalAlignment="Left" Margin="128,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Photo Viewer" HorizontalAlignment="Left" Margin="346,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="File Association:" HorizontalAlignment="Left" Margin="301,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PVFileAssociation_Combo" HorizontalAlignment="Left" Margin="392,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Add &quot;Open with...&quot;:" HorizontalAlignment="Left" Margin="285,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PVOpenWithMenu_Combo" HorizontalAlignment="Left" Margin="392,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Rectangle Fill="#FFFFFFFF" Height="1" Margin="254,106,0,0" Stroke="Black" VerticalAlignment="Top"/>
					<Label Content="Lockscreen" HorizontalAlignment="Left" Margin="352,111,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Lockscreen:" HorizontalAlignment="Left" Margin="323,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LockScreen_Combo" HorizontalAlignment="Left" Margin="392,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Power Menu:" HorizontalAlignment="Left" Margin="316,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PowerMenuLockScreen_Combo" HorizontalAlignment="Left" Margin="392,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Camera:" HorizontalAlignment="Left" Margin="342,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CameraOnLockscreen_Combo" HorizontalAlignment="Left" Margin="392,196,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Name="AccountProtectionWarn_Txt" Content="Account Protection Warning:" HorizontalAlignment="Left" Margin="9,227,0,0" VerticalAlignment="Top" Width="166"/>
					<ComboBox Name="AccountProtectionWarn_Combo" HorizontalAlignment="Left" Margin="168,229,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="MetroApp_Tab" Header="Metro App" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Set All Metro Apps:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="72,2,0,0"/>
					<Rectangle Fill="#FFFFFFFF" Height="1" Margin="0,29,0,0" Stroke="Black" VerticalAlignment="Top" HorizontalAlignment="Left" Width="347"/>
					<ComboBox Name="AllMetro_Combo" HorizontalAlignment="Left" Margin="181,4,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="3DBuilder:" HorizontalAlignment="Left" Margin="32,32,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_3DBuilder_Combo" HorizontalAlignment="Left" Margin="94,35,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="3DViewer:" HorizontalAlignment="Left" Margin="34,56,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_3DViewer_Combo" HorizontalAlignment="Left" Margin="94,59,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Bing Weather:" HorizontalAlignment="Left" Margin="12,80,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_BingWeather_Combo" HorizontalAlignment="Left" Margin="94,83,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Phone App:" HorizontalAlignment="Left" Margin="26,104,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_CommsPhone_Combo" HorizontalAlignment="Left" Margin="94,107,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Calendar &amp; Mail:" HorizontalAlignment="Left" Margin="-1,128,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Communications_Combo" HorizontalAlignment="Left" Margin="94,131,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Getting Started:" HorizontalAlignment="Left" Margin="4,152,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Getstarted_Combo" HorizontalAlignment="Left" Margin="94,155,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Messaging App:" HorizontalAlignment="Left" Margin="2,176,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Messaging_Combo" HorizontalAlignment="Left" Margin="94,179,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Get Office:" HorizontalAlignment="Left" Margin="31,203,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_MicrosoftOffHub_Combo" HorizontalAlignment="Left" Margin="94,203,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Movie Moments:" HorizontalAlignment="Left" Margin="-2,224,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_MovieMoments_Combo" HorizontalAlignment="Left" Margin="94,227,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Netflix:" HorizontalAlignment="Left" Margin="225,32,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Netflix_Combo" HorizontalAlignment="Left" Margin="269,35,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Office OneNote:" HorizontalAlignment="Left" Margin="173,56,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_OfficeOneNote_Combo" HorizontalAlignment="Left" Margin="269,59,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Office Sway:" HorizontalAlignment="Left" Margin="198,80,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_OfficeSway_Combo" HorizontalAlignment="Left" Margin="269,83,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="One Connect:" HorizontalAlignment="Left" Margin="190,104,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_OneConnect_Combo" HorizontalAlignment="Left" Margin="269,107,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="People:" HorizontalAlignment="Left" Margin="224,128,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_People_Combo" HorizontalAlignment="Left" Margin="269,131,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Photos App:" HorizontalAlignment="Left" Margin="198,152,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Photos_Combo" HorizontalAlignment="Left" Margin="269,155,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Skype:" HorizontalAlignment="Left" Margin="227,176,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_SkypeApp_Combo" HorizontalAlignment="Left" Margin="269,179,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Solitaire Collect:" HorizontalAlignment="Left" Margin="177,200,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_SolitaireCollect_Combo" HorizontalAlignment="Left" Margin="269,203,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Sticky Notes:" HorizontalAlignment="Left" Margin="194,224,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_StickyNotes_Combo" HorizontalAlignment="Left" Margin="269,227,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Voice Recorder:" HorizontalAlignment="Left" Margin="353,32,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_VoiceRecorder_Combo" HorizontalAlignment="Left" Margin="442,35,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Alarms &amp; Clock:" HorizontalAlignment="Left" Margin="351,56,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsAlarms_Combo" HorizontalAlignment="Left" Margin="442,59,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Calculator:" HorizontalAlignment="Left" Margin="379,80,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsCalculator_Combo" HorizontalAlignment="Left" Margin="442,83,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Camera:" HorizontalAlignment="Left" Margin="392,104,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsCamera_Combo" HorizontalAlignment="Left" Margin="442,107,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Win. Feedback:" HorizontalAlignment="Left" Margin="355,128,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsFeedbak_Combo" HorizontalAlignment="Left" Margin="442,131,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Windows Maps:" HorizontalAlignment="Left" Margin="351,152,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsMaps_Combo" HorizontalAlignment="Left" Margin="442,155,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Phone Comp.:" HorizontalAlignment="Left" Margin="361,176,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsPhone_Combo" HorizontalAlignment="Left" Margin="442,179,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="All Xbox Apps:" HorizontalAlignment="Left" Margin="359,200,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_XboxApp_Combo" HorizontalAlignment="Left" Margin="442,203,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Groove:" HorizontalAlignment="Left" Margin="394,224,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Zune_Combo" HorizontalAlignment="Left" Margin="442,227,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Windows Store:" HorizontalAlignment="Left" Margin="353,8,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsStore_Combo" HorizontalAlignment="Left" Margin="442,11,0,0" VerticalAlignment="Top" Width="74"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="171,29,0,-2" Stroke="Black" Width="1"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="346,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="Get Help App:" HorizontalAlignment="Left" Margin="13,248,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_GetHelp_Combo" HorizontalAlignment="Left" Margin="94,251,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Wallet App:" HorizontalAlignment="Left" Margin="201,248,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsWallet_Combo" HorizontalAlignment="Left" Margin="269,251,0,0" VerticalAlignment="Top" Width="74"/>
				</Grid>
			</TabItem>
			<TabItem Name="Application_Tab" Header="Application/Windows Update" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Application/Feature" HorizontalAlignment="Left" Margin="79,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="OneDrive:" HorizontalAlignment="Left" Margin="69,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="OneDrive_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="OneDrive Install:" HorizontalAlignment="Left" Margin="34,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="OneDriveInstall_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Content="Xbox DVR:" HorizontalAlignment="Left" Margin="66,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="XboxDVR_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="MediaPlayer:" HorizontalAlignment="Left" Margin="53,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="MediaPlayer_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Content="Work Folders:" HorizontalAlignment="Left" Margin="49,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WorkFolders_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Name="LinuxSubsystem_Txt" Content="Linux Subsystem:" HorizontalAlignment="Left" Margin="31,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LinuxSubsystem_Combo" HorizontalAlignment="Left" Margin="128,196,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Content="Windows Update" HorizontalAlignment="Left" Margin="336,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Check for Update:" HorizontalAlignment="Left" Margin="290,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CheckForWinUpdate_Combo" HorizontalAlignment="Left" Margin="392,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Update Check Type:" HorizontalAlignment="Left" Margin="280,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinUpdateType_Combo" HorizontalAlignment="Left" Margin="392,61,0,0" VerticalAlignment="Top" Width="115"/>
					<Label Content="Update P2P:" HorizontalAlignment="Left" Margin="320,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinUpdateDownload_Combo" HorizontalAlignment="Left" Margin="392,88,0,0" VerticalAlignment="Top" Width="83"/>
					<Label Content="Update MSRT:" HorizontalAlignment="Left" Margin="310,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UpdateMSRT_Combo" HorizontalAlignment="Left" Margin="392,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Update Driver:" HorizontalAlignment="Left" Margin="309,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UpdateDriver_Combo" HorizontalAlignment="Left" Margin="392,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Restart on Update:" HorizontalAlignment="Left" Margin="287,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RestartOnUpdate_Combo" HorizontalAlignment="Left" Margin="392,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="Update Available Popup:" HorizontalAlignment="Left" Margin="256,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UpdateAvailablePopup_Combo" HorizontalAlignment="Left" Margin="392,196,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Fax And Scan:" HorizontalAlignment="Left" Margin="49,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="FaxAndScan_Combo" HorizontalAlignment="Left" Margin="128,169,0,0" VerticalAlignment="Top" Width="78"/>
				</Grid>
			</TabItem>
		</TabControl>
		<Button Name="RunScriptButton" Content="Run Script" VerticalAlignment="Bottom" Height="20" FontWeight="Bold"/>
		<Rectangle Fill="#FFFFFFFF" Height="1" Margin="0,0,0,20" Stroke="Black" VerticalAlignment="Bottom"/>
	</Grid>
</Window>
"@
	[Void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
	$Form = [Windows.Markup.XamlReader]::Load( (New-Object System.Xml.XmlNodeReader $xaml) )
	$xaml.SelectNodes('//*[@Name]').ForEach{Set-Variable -Name "WPF_$($_.Name)" -Value $Form.FindName($_.Name) -Scope Script}
	$Runspace = [RunSpaceFactory]::CreateRunspace()
	$PowerShell = [PowerShell]::Create()
	$PowerShell.RunSpace = $Runspace
	$Runspace.Open()
	[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null

	$Script:WPFList = Get-Variable -Name 'WPF_*'
	[System.Collections.ArrayList]$VarList = AppAraySet 'WPF_*_Combo'
	[System.Collections.ArrayList]$ListApp = AppAraySet 'APP_*'

	$WPF_Madbomb122WSButton.Add_Click{ OpenWebsite 'https://GitHub.com/madbomb122/' }
	$WPF_FeedbackButton.Add_Click{ OpenWebsite "$MySite/issues" }
	$WPF_FAQButton.Add_Click{ OpenWebsite "$MySite/blob/master/README.md" }
	$WPF_DonateButton.Add_Click{ OpenWebsite $Donate_Url }
	$WPF_CreateRestorePoint_CB.Add_Click{ $WPF_RestorePointName_Txt.IsEnabled = $WPF_CreateRestorePoint_CB.IsChecked }
	$WPF_RunScriptButton.Add_Click{ GuiDone }
	$WPF_WinDefault_Button.Add_Click{ LoadWinDefault ;SelectComboBox $VarList }
	$WPF_ResetDefault_Button.Add_Click{ SetDefault ;SelectComboBox $VarList ;SelectComboBox $ListApp 1 }
	$WPF_Load_Setting_Button.Add_Click{ OpenSaveDiaglog 0 }
	$WPF_Save_Setting_Button.Add_Click{ OpenSaveDiaglog 1 }
	$WPF_AboutButton.Add_Click{ [Windows.Forms.Messagebox]::Show('This script lets you do Various Settings and Tweaks for Windows 10. For manual or Automated use.','About', 'OK') | Out-Null }
	$WPF_CopyrightButton.Add_Click{ [Windows.Forms.Messagebox]::Show($Copyright,'Copyright', 'OK') | Out-Null }
	$WPF_AllMetro_Combo.add_SelectionChanged{ SelectComboBoxAllMetro ($WPF_AllMetro_Combo.SelectedIndex) }

$Skip_EnableD_Disable = @(
'Telemetry',
'WiFiSense',
'SmartScreen',
'LocationTracking',
'Feedback',
'AdvertisingID',
'Cortana',
'CortanaSearch',
'ErrorReporting',
'AutoLoggerFile',
'DiagTrack',
'WAPPush',
'CheckForWinUpdate',
'UpdateMSRT',
'UpdateDriver',
'RestartOnUpdate',
'AppAutoDownload',
'AdminShares',
'Firewall',
'WinDefender',
'HomeGroups',
'RemoteAssistance',
'CastToDevice',
'PreviousVersions',
'IncludeinLibrary',
'PinToStart',
'PinToQuickAccess',
'ShareWith',
'SendTo',
'OneDrive',
'XboxDVR',
'TaskBarOnMultiDisplay',
'StartMenuWebSearch',
'StartSuggestions',
'RecentItemsFrequent',
'Autoplay',
'Autorun',
'AeroSnap',
'AeroShake',
'StoreOpenWith',
'LockScreen',
'CameraOnLockScreen',
'ActionCenter',
'AccountProtectionWarn',
'StickyKeyPrompt',
'SleepPower',
'ReopenAppsOnBoot',
'Timeline',
'UpdateAvailablePopup',
'AppHibernationFile')

$Skip_Enable_DisableD = @(
'SharingMappedDrives',
'RemoteDesktop',
'LastActiveClick',
'NumblockOnStart',
'F8BootMenu',
'RemoteUACAcctToken',
'PVFileAssociation',
'PVOpenWithMenu',
'LongFilePath')

$Skip_ShowD_Hide = @(
'TaskbarSearchBox',
'TaskViewButton',
'MostUsedAppStartMenu',
'FrequentFoldersQikAcc',
'WinContentWhileDrag',
'RecycleBinOnDesktop',
'PowerMenuLockScreen')

$Skip_ShowD_Hide_Remove = @(
'DesktopIconInThisPC',
'DocumentsIconInThisPC',
'DownloadsIconInThisPC',
'ThreeDobjectsIconInThisPC',
'MusicIconInThisPC',
'PicturesIconInThisPC',
'VideosIconInThisPC')


$Skip_Show_HideD = @(
'SecondsInClock',
'PidInTitleBar',
'KnownExtensions',
'HiddenFiles',
'SystemFiles',
'TaskManagerDetails',
'ThisPCOnDesktop',
'NetworkOnDesktop',
'UsersFileOnDesktop',
'ControlPanelOnDesktop')

$Skip_InstalledD_Uninstall = @('OneDriveInstall','MediaPlayer','WorkFolders','FaxAndScan')

	If($Release_Type -eq 'Testing'){ $Script:Restart = 0 ;$WPF_Restart_CB.IsEnabled = $False ;$WPF_Restart_CB.Content += ' (Disabled in Testing Version)' }
	If($Win10Ver -lt 1607){ $WPF_LinuxSubsystem_Combo.Visibility = 'Hidden' ;$WPF_LinuxSubsystem_Txt.Visibility = 'Hidden' }
	If($Win10Ver -lt 1709){
		$WPF_ThreeDobjectsIconInThisPC_Combo.Visibility = 'Hidden' ;$WPF_ThreeDobjectsIconInThisPC_txt.Visibility = 'Hidden'
		$WPF_ReopenAppsOnBoot_Combo.Visibility = 'Hidden' ;$WPF_ReopenAppsOnBoot_txt.Visibility = 'Hidden'
	}
	If($Win10Ver -lt 1803){
		$WPF_AccountProtectionWarn_Combo.Visibility = 'Hidden' ;$WPF_AccountProtectionWarn_Txt.Visibility = 'Hidden'
		$WPF_Timeline_Combo.Visibility = 'Hidden' ;$WPF_Timeline_Txt.Visibility = 'Hidden'
	}
	ForEach($Var In $Skip_EnableD_Disable){ SetCombo $Var 'Enable*,Disable' }
	ForEach($Var In $Skip_Enable_DisableD){ SetCombo $Var 'Enable,Disable*' }
	ForEach($Var In $Skip_ShowD_Hide_Remove){ SetCombo $Var 'Show/Add*,Hide,Remove**' }
	ForEach($Var In $Skip_ShowD_Hide){ SetCombo $Var 'Show*,Hide' }
	ForEach($Var In $Skip_Show_HideD){ SetCombo $Var 'Show,Hide*' }
	ForEach($Var In $Skip_InstalledD_Uninstall){ SetCombo $Var 'Installed*,Uninstall' }

	SetComboM 'AllMetro' 'Unhide,Hide,Uninstall'
	ForEach($MetroApp In $ListApp){ SetComboM $MetroApp 'Unhide,Hide,Uninstall' }

	SetCombo 'LinuxSubsystem' 'Installed,Uninstall*'
	SetCombo 'HibernatePower' 'Enable,Disable'
	SetCombo 'UAC' 'Disable,Normal*,Higher'
	SetCombo 'BatteryUIBar' 'New*,Classic'
	SetCombo 'ClockUIBar' 'New*,Classic'
	SetCombo 'VolumeControlBar' 'New(Horizontal)*,Classic(Vertical)'
	SetCombo 'TaskbarIconSize' 'Normal*,Smaller'
	SetCombo 'TaskbarGrouping' 'Never,Always*,When Needed'
	SetCombo 'TrayIcons' 'Auto*,Always Show'
	SetCombo 'TaskBarButtOnDisplay' 'All,Where Window is Open,Main & Where Window is Open'
	SetCombo 'UnpinItems' 'Unpin'
	SetCombo 'ExplorerOpenLoc' 'Quick Access*,ThisPC'
	SetCombo 'RecentFileQikAcc' 'Show/Add*,Hide,Remove'
	SetCombo 'WinXPowerShell' 'PowerShell,Command Prompt'
	SetCombo 'WinUpdateType' 'Notify,Auto DL,Auto DL+Install*,Admin Config'
	SetCombo 'WinUpdateDownload' 'P2P*,Local Only,Disable'

	ConfigGUIitms
	If($Release_Type -ne 'Stable'){ $Form.Title += " -$Release_Type)" } Else{ $Form.Title += ')' }
	Clear-Host
	DisplayOut 'Displaying GUI Now' -C 14
	DisplayOut "`nTo exit you can close the GUI or PowerShell Window." -C 14
	$Form.ShowDialog() | Out-Null
}

Function GuiDone {
	GuiItmToVariable
	$Form.Close()
	$Script:RunScr = $True
	RunScript
}

Function GuiItmToVariable {
	ForEach($Var In $ListApp) {
		$Value = ($(Get-Variable -Name ('WPF_'+$Var+'_Combo') -ValueOnly).SelectedIndex)
		If($Var -eq 'APP_SkypeApp') {
			Set-Variable -Name 'APP_SkypeApp1' -Value $Value -Scope Script ;Set-Variable -Name 'APP_SkypeApp2' -Value $Value -Scope Script
		} ElseIf($Var -eq 'APP_WindowsFeedbak') {
			Set-Variable -Name 'APP_WindowsFeedbak1' -Value $Value -Scope Script ;Set-Variable -Name 'APP_WindowsFeedbak2' -Value $Value -Scope Script
		} ElseIf($Var -eq 'APP_Zune') {
			Set-Variable -Name 'APP_ZuneMusic' -Value $Value -Scope Script ;Set-Variable -Name 'APP_ZuneVideo' -Value $Value -Scope Script
		} Else {
			Set-Variable -Name $Var -Value $Value -Scope Script
		}
	}
	ForEach($Var In $VarList){ Set-Variable -Name $Var -Value ($(Get-Variable -Name ('WPF_'+$Var+'_Combo') -ValueOnly).SelectedIndex) -Scope Script }
	If($WPF_CreateRestorePoint_CB.IsChecked){ $Script:CreateRestorePoint = 1 } Else{ $Script:CreateRestorePoint = 0 }
	If($WPF_VersionCheck_CB.IsChecked){ $Script:VersionCheck = 1 } Else{ $Script:VersionCheck = 0 }
	If($WPF_InternetCheck_CB.IsChecked){ $Script:InternetCheck = 1 } Else{ $Script:InternetCheck = 0 }
	If($WPF_ShowSkipped_CB.IsChecked){ $Script:ShowSkipped = 1 } Else{ $Script:ShowSkipped = 0 }
	If($WPF_Restart_CB.IsChecked){ $Script:Restart = 1 } Else { $Script:Restart = 0 }
	$Script:RestorePointName = $WPF_RestorePointName_Txt.Text
}

##########
# GUI -End
##########
# Pre-Made Settings -Start
##########

Function LoadWinDefault {
	#Privacy Settings
	$Script:Telemetry = 1
	$Script:WiFiSense = 1
	$Script:SmartScreen = 1
	$Script:LocationTracking = 1
	$Script:Feedback = 1
	$Script:AdvertisingID = 1
	$Script:Cortana = 1
	$Script:CortanaSearch = 1
	$Script:ErrorReporting = 1
	$Script:AutoLoggerFile = 1
	$Script:DiagTrack = 1
	$Script:WAPPush = 1

	#Windows Update
	$Script:CheckForWinUpdate = 1
	$Script:WinUpdateType = 3
	$Script:WinUpdateDownload = 1
	$Script:UpdateMSRT = 1
	$Script:UpdateDriver = 1
	$Script:RestartOnUpdate = 1
	$Script:AppAutoDownload = 1
	$Script:UpdateAvailablePopup = 1

	#Service Tweaks
	$Script:UAC = 2
	$Script:SharingMappedDrives = 2
	$Script:AdminShares = 1
	$Script:Firewall = 1
	$Script:WinDefender = 1
	$Script:HomeGroups = 1
	$Script:RemoteAssistance = 1
	$Script:RemoteDesktop = 2

	#Context Menu Items
	$Script:CastToDevice = 1
	$Script:PreviousVersions = 1
	$Script:IncludeinLibrary = 1
	$Script:PinToStart = 1
	$Script:PinToQuickAccess = 1
	$Script:ShareWith = 1
	$Script:SendTo = 1

	#Task Bar Items
	$Script:BatteryUIBar = 1
	$Script:ClockUIBar = 1
	$Script:VolumeControlBar = 1
	$Script:TaskbarSearchBox = 1
	$Script:TaskViewButton = 1
	$Script:TaskbarIconSize = 1
	$Script:TaskbarGrouping = 2
	$Script:TrayIcons = 1
	$Script:SecondsInClock = 2
	$Script:LastActiveClick = 2
	$Script:TaskBarOnMultiDisplay = 1

	#Star Menu Items
	$Script:StartMenuWebSearch = 1
	$Script:StartSuggestions = 1
	$Script:MostUsedAppStartMenu = 1
	$Script:RecentItemsFrequent = 1

	#Explorer Items
	$Script:Autoplay = 1
	$Script:Autorun = 1
	$Script:PidInTitleBar = 2
	$Script:AeroSnap = 1
	$Script:AeroShake = 1
	$Script:KnownExtensions = 2
	$Script:HiddenFiles = 2
	$Script:SystemFiles = 2
	$Script:ExplorerOpenLoc = 1
	$Script:RecentFileQikAcc = 1
	$Script:FrequentFoldersQikAcc = 1
	$Script:WinContentWhileDrag = 1
	$Script:StoreOpenWith = 1
	If($Win10Ver -ge 1703){ $Script:WinXPowerShell = 1 } Else{ $Script:WinXPowerShell = 2 }
	$Script:TaskManagerDetails = 2
	$Script:ReopenAppsOnBoot = 1
	$Script:Timeline = 1
	$Script:LongFilePath = 2
	$Script:AppHibernationFile = 1

	#'This PC' Items
	$Script:DesktopIconInThisPC = 1
	$Script:DocumentsIconInThisPC = 1
	$Script:DownloadsIconInThisPC = 1
	$Script:MusicIconInThisPC = 1
	$Script:PicturesIconInThisPC = 1
	$Script:VideosIconInThisPC = 1
	$Script:ThreeDobjectsIconInThisPC = 1

	#Desktop Items
	$Script:ThisPCOnDesktop = 2
	$Script:NetworkOnDesktop = 2
	$Script:RecycleBinOnDesktop = 1
	$Script:UsersFileOnDesktop = 2
	$Script:ControlPanelOnDesktop = 2

	#Lock Screen
	$Script:LockScreen = 1
	$Script:PowerMenuLockScreen = 1
	$Script:CameraOnLockScreen = 1

	#Misc items
	$Script:AccountProtectionWarn = 1
	$Script:ActionCenter = 1
	$Script:StickyKeyPrompt = 1
	$Script:NumblockOnStart = 2
	$Script:F8BootMenu = 1
	$Script:RemoteUACAcctToken = 2
	$Script:SleepPower = 1

	# Photo Viewer Settings
	$Script:PVFileAssociation = 2
	$Script:PVOpenWithMenu = 2

	# Remove unwanted applications
	$Script:OneDrive = 1
	$Script:OneDriveInstall = 1
	$Script:XboxDVR = 1
	$Script:MediaPlayer = 1
	$Script:WorkFolders = 1
	$Script:FaxAndScan = 1
	$Script:LinuxSubsystem = 2
}

##########
# Pre-Made Settings -End
##########
# Script -Start
##########

Function RunScript {
	If($VersionCheck -eq 1){ UpdateCheck }

	BoxItem 'Pre-Script'
	If($CreateRestorePoint -eq 0 -And $ShowSkipped -eq 1) {
		DisplayOut 'Skipping Creation of System Restore Point...' -C 15
	} ElseIf($CreateRestorePoint -eq 1) {
		DisplayOut "Creating System Restore Point Named '$RestorePointName'" -C 11
		DisplayOut 'Please Wait...' -C 11
		Checkpoint-Computer -Description $RestorePointName | Out-Null
	}

	If(!(Test-Path 'HKCR:')){ New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null }
	If(!(Test-Path 'HKU:')){ New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null }
	$AppxCount = 0

	BoxItem 'Metro App Items'
	$APPProcess = Get-Variable -Name 'APP_*' -ValueOnly -Scope Script
	$A = 0

	ForEach($AppV In $APPProcess) {
		$AP = $AppsList[$A]
		If($AppV -eq 1) {
			If($AP -ne 'XboxApps'){
				[Void]$APPS_AppsUnhide.Add($AP)
			} Else {
				ForEach($AppX In $Xbox_Apps){ [Void]$APPS_AppsUnhide.Add($AppX) }
			}
		} ElseIf($AppV -eq 2) {
			If($AP -ne 'XboxApps'){
				[Void] $APPS_AppsHide.Add($AP)
			} Else {
				ForEach($AppX In $Xbox_Apps){ [Void]$APPS_AppsHide.Add($AppX) }
			}
		} ElseIf($AppV -eq 3) {
			If($AP -ne 'XboxApps'){
				[Void] $APPS_AppsUninstall.Add($AP)
			} Else {
				ForEach($AppX In $Xbox_Apps){ [Void]$APPS_AppsUninstall.Add($AppX) }
			}
		} $A++
	}

	$Ai = $APPS_AppsUnhide.Length
	$Ah = $APPS_AppsHide.Length
	$Au = $APPS_AppsUninstall.Length
	If($null -Notin $Ah,$Au){ $AppxPackages = Get-AppxProvisionedPackage -online | select-object PackageName,Displayname }

	DisplayOut "List of Apps Being Unhidden...`n------------------" 11 0
	If($Ai -ne $null) {
		ForEach($AppI In $APPS_AppsUnhide) {
			$AppInst = Get-AppxPackage -AllUsers $AppI
			If($AppInst -ne $null) {
				DisplayOut $AppI 11 0
				ForEach($App In $AppInst){
					$AppxCount++
					$Job = "Win10Script$AppxCount"
					Start-Job -Name $Job -ScriptBlock { Add-AppxPackage -DisableDevelopmentMode -Register "$($App.InstallLocation)\AppXManifest.xml" }
				}
			} Else {
				DisplayOut "Unable to Unhide $AppI" -C 11
			}
		}
	} Else {
		DisplayOut 'No Apps being Unhidden' -C 11
	}
	DisplayOut "`nList of Apps Being Hiddden...`n-----------------" -C 12
	If($Ah -ne $null) {
		ForEach($AppH In $APPS_AppsHide) {
			If($AppxPackages.DisplayName.Contains($AppH)) {
				DisplayOut $AppH 12 0
				$AppxCount++
				$Job = "Win10Script$AppxCount"
				Start-Job -Name $Job -ScriptBlock { Get-AppxPackage $AppH | Remove-AppxPackage | Out-null }
			} Else {
				DisplayOut "$AppH Isn't Installed" -C 12
			}
		}
	} Else {
		DisplayOut 'No Apps being Hidden' -C 12
	}
	DisplayOut "`nList of Apps Being Uninstalled...`n--------------------" -C 14
	If($Au -ne $null) {
		ForEach($AppU In $APPS_AppsUninstall) {
			If($AppxPackages.DisplayName.Contains($AppU)) {
				DisplayOut $AppU 14 0
				$PackageFullName = (Get-AppxPackage $AppU).PackageFullName
				$ProPackageFullName = ($AppxPackages.Where{$_.Displayname -eq $AppU}).PackageName
				# Alt removal: DISM /Online /Remove-ProvisionedAppxPackage /PackageName:
				$AppxCount++
				$Job = "Win10Script$AppxCount"
				Start-Job -Name $Job -ScriptBlock {
					Remove-AppxPackage -Package $using:PackageFullName | Out-null
					Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackageFullName | Out-null
				}
			} Else {
				DisplayOut "$AppU Isn't Installed" -C 14
			}
		}
	} Else {
		DisplayOut 'No Apps being Uninstalled' -C 14
	}

	BoxItem 'Privacy Settings'
	If($Telemetry -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Telemetry...' -C 15 }
	} ElseIf($Telemetry -eq 1) {
		DisplayOut 'Enabling Telemetry...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3
		If($OSBit -eq 64){ Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3 }
	} ElseIf($Telemetry -eq 2) {
		DisplayOut 'Disabling Telemetry...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
		If($OSBit -eq 64){ Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0 }
	}

	If($WiFiSense -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Wi-Fi Sense...' -C 15 }
	} ElseIf($WiFiSense -eq 1) {
		DisplayOut 'Enabling Wi-Fi Sense...' -C 11
		$Path1 = 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi'
		$Path = CheckSetPath "$Path1\AllowWiFiHotSpotReporting"
		Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 1
		$Path = CheckSetPath "$Path1\AllowAutoConnectToWiFiSenseHotspots"
		Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 1
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config'
		Set-ItemProperty -Path $Path -Name 'AutoConnectAllowedOEM' -Type Dword -Value 0
		Set-ItemProperty -Path $Path -Name 'WiFISenseAllowed' -Type Dword -Value 0
	} ElseIf($WiFiSense -eq 2) {
		DisplayOut 'Disabling Wi-Fi Sense...' -C 12
		$Path1 = 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi'
		$Path = CheckSetPath "$Path1\AllowWiFiHotSpotReporting"
		Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 0
		$Path = CheckSetPath "$Path1\AllowAutoConnectToWiFiSenseHotspots"
		Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 0
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'AutoConnectAllowedOEM'
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'WiFISenseAllowed'
	}

	If($SmartScreen -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping SmartScreen Filter...' -C 15 }
	} ElseIf($SmartScreen -eq 1) {
		DisplayOut 'Enabling SmartScreen Filter...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'SmartScreenEnabled' -Type String -Value 'RequireAdmin'
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' -Name 'EnableWebContentEvaluation'
		If($Win10Ver -ge 1703) {
			$AddPath = (Get-AppxPackage -AllUsers 'Microsoft.MicrosoftEdge').PackageFamilyName
			$Path = "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$AddPath\MicrosoftEdge\PhishingFilter"
			Remove-ItemProperty -Path $Path -Name 'EnabledV9'
			Remove-ItemProperty -Path $Path -Name 'PreventOverride'
		}
	} ElseIf($SmartScreen -eq 2) {
		DisplayOut 'Disabling SmartScreen Filter...' -C 12
		$Path = 'SOFTWARE\Microsoft\Windows\CurrentVersion'
		Set-ItemProperty -Path "HKLM:\$Path\Explorer" -Name 'SmartScreenEnabled' -Type String -Value 'Off'
		Set-ItemProperty -Path "HKCU:\$Path\AppHost" -Name 'EnableWebContentEvaluation' -Type DWord -Value 0
		If($Win10Ver -ge 1703) {
			$AddPath = (Get-AppxPackage -AllUsers 'Microsoft.MicrosoftEdge').PackageFamilyName
			$Path = CheckSetPath "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$AddPath\MicrosoftEdge\PhishingFilter"
			Set-ItemProperty -Path $Path -Name 'EnabledV9' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'PreventOverride' -Type DWord -Value 0
		}
	}

	If($LocationTracking -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Location Tracking...' -C 15 }
	} ElseIf($LocationTracking -eq 1) {
		DisplayOut 'Enabling Location Tracking...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' -Name 'SensorPermissionState' -Type DWord -Value 1
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' -Name 'Status' -Type DWord -Value 1
	} ElseIf($LocationTracking -eq 2) {
		DisplayOut 'Disabling Location Tracking...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' -Name 'SensorPermissionState' -Type DWord -Value 0
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' -Name 'Status' -Type DWord -Value 0
	}

	If($Feedback -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Feedback...' -C 15 }
	} ElseIf($Feedback -eq 1) {
		DisplayOut 'Enabling Feedback...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules' -Name 'NumberOfSIUFInPeriod'
	} ElseIf($Feedback -eq 2) {
		DisplayOut 'Disabling Feedback...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules'
		Set-ItemProperty -Path $Path -Name 'NumberOfSIUFInPeriod' -Type DWord -Value 0
	}

	If($AdvertisingID -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Advertising ID...' -C 15 }
	} ElseIf($AdvertisingID -eq 1) {
		DisplayOut 'Enabling Advertising ID...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name 'Enabled'
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy'
		Set-ItemProperty -Path $Path -Name 'TailoredExperiencesWithDiagnosticDataEnabled' -Type DWord -Value 2
	} ElseIf($AdvertisingID -eq 2) {
		DisplayOut 'Disabling Advertising ID...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
		Set-ItemProperty -Path $Path -Name 'Enabled' -Type DWord -Value 0
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy'
		Set-ItemProperty -Path $Path -Name 'TailoredExperiencesWithDiagnosticDataEnabled' -Type DWord -Value 0
	}

	If($Cortana -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Cortana...' -C 15 }
	} ElseIf($Cortana -eq 1) {
		DisplayOut 'Enabling Cortana...' -C 11
		$Path = 'HKCU:\SOFTWARE\Microsoft\InputPersonalization'
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy'
		Remove-ItemProperty -Path "$Path\TrainedDataStore" -Name 'HarvestContacts'
		Set-ItemProperty -Path $Path -Name 'RestrictImplicitTextCollection' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'RestrictImplicitInkCollection' -Type DWord -Value 0
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
		Remove-ItemProperty -Path $Path -Name 'AllowCortanaAboveLock'
		Remove-ItemProperty -Path $Path -Name 'ConnectedSearchUseWeb'
		Remove-ItemProperty -Path $Path -Name 'ConnectedSearchPrivacy'
		Set-ItemProperty -Path $Path -Name 'DisableWebSearch' -Type DWord -Value 1
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Preferences\'
		Set-ItemProperty -Path $Path -Name 'VoiceActivationEnableAboveLockscreen' -Type DWord -Value 1
	} ElseIf($Cortana -eq 2) {
		DisplayOut 'Disabling Cortana...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings'
		Set-ItemProperty -Path $Path -Name 'AcceptedPrivacyPolicy' -Type DWord -Value 0
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\InputPersonalization'
		Set-ItemProperty -Path $Path -Name 'RestrictImplicitTextCollection' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'RestrictImplicitInkCollection' -Type DWord -Value 1
		$Path = CheckSetPath "$Path\TrainedDataStore"
		Set-ItemProperty -Path $Path -Name 'HarvestContacts' -Type DWord -Value 0
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
		Set-ItemProperty -Path $Path -Name 'AllowCortanaAboveLock' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'ConnectedSearchUseWeb' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'ConnectedSearchPrivacy' -Type DWord -Value 3
		Remove-ItemProperty -Path $Path -Name 'DisableWebSearch'
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Preferences\'
		Set-ItemProperty -Path $Path -Name 'VoiceActivationEnableAboveLockscreen' -Type DWord -Value 0
	}

	If($CortanaSearch -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Cortana Search...' -C 15 }
	} ElseIf($CortanaSearch -eq 1) {
		DisplayOut 'Enabling Cortana Search...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana'
	} ElseIf($CortanaSearch -eq 2) {
		DisplayOut 'Disabling Cortana Search...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
		Set-ItemProperty -Path $Path -Name 'AllowCortana' -Type DWord -Value 0
	}

	If($ErrorReporting -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Error Reporting...' -C 15 }
	} ElseIf($ErrorReporting -eq 1) {
		DisplayOut 'Enabling Error Reporting...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' -Name 'Disabled'
	} ElseIf($ErrorReporting -eq 2) {
		DisplayOut 'Disabling Error Reporting...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' -Name 'Disabled' -Type DWord -Value 1
	}

	If($AutoLoggerFile -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping AutoLogger...' -C 15 }
	} ElseIf($AutoLoggerFile -eq 1) {
		DisplayOut 'Unrestricting AutoLogger Directory...' -C 11
		$autoLoggerDir = "$Env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		icacls $autoLoggerDir /grant:r SYSTEM:`(OI`)`(CI`)F | Out-Null
		$Path = CheckSetPath 'HKLM:\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener'
		Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 1
		$Path += '\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA}'
		Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 1
	} ElseIf($AutoLoggerFile -eq 2) {
		DisplayOut 'Removing AutoLogger File and Restricting Directory...' -C 12
		$autoLoggerDir = "$Env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		RemoveSetPath "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
		icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null
		$Path = CheckSetPath 'HKLM:\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener'
		Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 0
		$Path = CheckSetPath "$Path\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA}"
		Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 0
	}

	If($DiagTrack -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Diagnostics Tracking...' -C 15 }
	} ElseIf($DiagTrack -eq 1) {
		DisplayOut 'Enabling and Starting Diagnostics Tracking Service...' -C 11
		Set-Service 'DiagTrack' -StartupType Automatic
		Start-Service 'DiagTrack'
	} ElseIf($DiagTrack -eq 2) {
		DisplayOut 'Stopping and Disabling Diagnostics Tracking Service...' -C 12
		Stop-Service 'DiagTrack'
		Set-Service 'DiagTrack' -StartupType Disabled
	}

	If($WAPPush -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping WAP Push...' -C 15 }
	} ElseIf($WAPPush -eq 1) {
		DisplayOut 'Enabling and Starting WAP Push Service...' -C 11
		Set-Service 'dmwappushservice' -StartupType Automatic
		Start-Service 'dmwappushservice'
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice' -Name 'DelayedAutoStart' -Type DWord -Value 1
	} ElseIf($WAPPush -eq 2) {
		DisplayOut 'Disabling WAP Push Service...' -C 12
		Stop-Service 'dmwappushservice'
		Set-Service 'dmwappushservice' -StartupType Disabled
	}

	If($AppAutoDownload -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping App Auto Download...' -C 15 }
	} ElseIf($AppAutoDownload -eq 1) {
		DisplayOut 'Enabling App Auto Download...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate' -Name 'AutoDownload' -Type DWord -Value 0
		Remove-ItemProperty  -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableWindowsConsumerFeatures'
	} ElseIf($AppAutoDownload -eq 2) {
		DisplayOut 'Disabling App Auto Download...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate'
		Set-ItemProperty -Path $Path -Name 'AutoDownload' -Type DWord -Value 2
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
		Set-ItemProperty -Path $Path -Name 'DisableWindowsConsumerFeatures' -Type DWord -Value 1
		If($Win10Ver -le 1803) {
			$key = Get-ChildItem -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount" -Recurse | Where-Object { $_ -like "*windows.data.placeholdertilecollection\Current" }
			$data = (Get-ItemProperty -Path $key.PSPath -Name "Data").Data[0..15]
			Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $data
			Stop-Process -Name "ShellExperienceHost" -Force
		}
	}

	BoxItem 'Windows Update Settings'
	$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
	If($CheckForWinUpdate -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Check for Windows Update...' -C 15 }
	} ElseIf($CheckForWinUpdate -eq 1) {
		DisplayOut 'Enabling Check for Windows Update...' -C 11
		Remove-ItemProperty -Path $Path -Name 'SetDisableUXWUAccess' -Type DWord -Value 0
	} ElseIf($CheckForWinUpdate -eq 2) {
		DisplayOut 'Disabling Check for Windows Update...' -C 12
		New-ItemProperty -Path $Path -Name 'SetDisableUXWUAccess' -Type DWord -Value 1
	}

	If($WinUpdateType -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Update Check Type...' -C 15 }
	} ElseIf($WinUpdateType -In 1..4) {
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
		If($WinUpdateType -eq 1) {
			DisplayOut 'Notify for windows update download and notify for install...' -C 14
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 2
		} ElseIf($WinUpdateType -eq 2) {
			DisplayOut 'Auto Download for windows update download and notify for install...' -C 14
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 3
		} ElseIf($WinUpdateType -eq 3) {
			DisplayOut 'Auto Download for windows update download and schedule for install...' -C 14
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 4
		} ElseIf($WinUpdateType -eq 4) {
			DisplayOut 'Windows update allow local admin to choose setting...' -C 14
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 5
		}
	}

	If($WinUpdateDownload -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Update P2P...' -C 15 }
	} ElseIf($WinUpdateDownload -eq 1) {
		DisplayOut 'Unrestricting Windows Update P2P to Internet...' -C 14
		$Path = 'SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization'
		Remove-ItemProperty -Path "HKLM:\$Path\Config" -Name 'DODownloadMode'
		Remove-ItemProperty -Path "HKCU:\$Path" -Name 'SystemSettingsDownloadMode'
	} ElseIf($WinUpdateDownload -eq 2) {
		DisplayOut 'Restricting Windows Update P2P only to local network...' -C 14
		$Path1 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization'
		$Path = CheckSetPath "HKCU:\$Path1"
		Set-ItemProperty -Path $Path -Name 'SystemSettingsDownloadMode' -Type DWord -Value 3
		If($Win10Ver -eq 1507) {
			$Path = CheckSetPath "HKLM:\$Path1\Config"
			Set-ItemProperty -Path $Path -Name 'DODownloadMode' -Type DWord -Value 1
		} ElseIf($Win10Ver -le 1607) {
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization'
			Set-ItemProperty -Path $Path -Name 'DODownloadMode' -Type DWord -Value 1
		} Else {
			Remove-ItemProperty -Path "HKLM:\$Path1" -Name "DODownloadMode"
		}
	} ElseIf($WinUpdateDownload -eq 3) {
		DisplayOut 'Disabling Windows Update P2P...' -C 12
		$Path1 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization'
		$Path = CheckSetPath "HKCU:\$Path1"
		Set-ItemProperty -Path $Path -Name 'SystemSettingsDownloadMode' -Type DWord -Value 3
		If($Win10Ver -eq 1507){
			$Path = CheckSetPath "HKLM:\$Path1\Config"
			Set-ItemProperty -Path $Path -Name 'DODownloadMode' -Type DWord -Value 0
		} Else {
			$Path = CheckSetPath "HKLM:\$Path1"
			Set-ItemProperty -Path $Path -Name 'DODownloadMode' -Type DWord -Value 100
		}
	}

	If($RestartOnUpdate -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Update Automatic Restart...' -C 15 }
	} ElseIf($RestartOnUpdate -eq 1) {
		DisplayOut 'Enabling Windows Update Automatic Restart...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'UxOption' -Type DWord -Value 0
		$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
		Remove-ItemProperty -Path $Path -Name 'NoAutoRebootWithLoggedOnUsers'
		Remove-ItemProperty -Path $Path -Name 'AUPowerManagement'
	} ElseIf($RestartOnUpdate -eq 2) {
		DisplayOut 'Disabling Windows Update Automatic Restart...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'UxOption' -Type DWord -Value 1
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
		Set-ItemProperty -Path $Path -Name 'NoAutoRebootWithLoggedOnUsers' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'AUPowerManagement' -Type DWord -Value 0
	}

	If($UpdateMSRT -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Malicious Software Removal Tool Update...' -C 15 }
	} ElseIf($UpdateMSRT -eq 1) {
		DisplayOut 'Enabling Malicious Software Removal Tool Update...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MRT' -Name 'DontOfferThroughWUAU'
	} ElseIf($UpdateMSRT -eq 2) {
		DisplayOut 'Disabling Malicious Software Removal Tool Update...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\MRT'
		Set-ItemProperty -Path $Path -Name 'DontOfferThroughWUAU' -Type DWord -Value 1
	}

	If($UpdateDriver -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Driver Update Through Windows Update...' -C 15 }
	} ElseIf($UpdateDriver -eq 1) {
		DisplayOut 'Enabling Driver Update Through Windows Update...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' -Name 'SearchOrderConfig' -Type DWord -Value 1
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ExcludeWUDriversInQualityUpdate'
	} ElseIf($UpdateDriver -eq 2) {
		DisplayOut 'Disabling Driver Update Through Windows Update...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' -Name 'SearchOrderConfig' -Type DWord -Value 0
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
		Set-ItemProperty -Path $Path -Name 'ExcludeWUDriversInQualityUpdate' -Type DWord -Value 1
	}

	If($UpdateAvailablePopup -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Update Available Popup...' -C 15 }
	} ElseIf($UpdateAvailablePopup -eq 1) {
		DisplayOut 'Enabling Update Available Popup...' -C 11
		ForEach($File In $musnotification_files){
			ICACLS $File /remove:d '"Everyone"' | out-null
			ICACLS $File /grant ('Everyone' + ':(OI)(CI)F') | out-null
			ICACLS $File /setowner 'NT SERVICE\TrustedInstaller'
			ICACLS $File /remove:g '"Everyone"' | out-null
		}
	} ElseIf($UpdateAvailablePopup -eq 2) {
		DisplayOut 'Disabling Update Available Popup...' -C 12
		ForEach($File In $musnotification_files){
			Takeown /f $File | out-null
			ICACLS $File /deny '"Everyone":(F)' | out-null
		}
	}

	BoxItem 'Service Tweaks'
	If($UAC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping UAC Level...' -C 15 }
	} ElseIf($UAC -eq 1) {
		DisplayOut 'Lowering UAC level...' -C 14
		$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
		Set-ItemProperty -Path $Path -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'PromptOnSecureDesktop' -Type DWord -Value 0
	} ElseIf($UAC -eq 2) {
		DisplayOut 'Default UAC level...' -C 14
		$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
		Set-ItemProperty -Path $Path -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 5
		Set-ItemProperty -Path $Path -Name 'PromptOnSecureDesktop' -Type DWord -Value 1
	} ElseIf($UAC -eq 3) {
		DisplayOut 'Raising UAC level...' -C 14
		$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
		Set-ItemProperty -Path $Path -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 2
		Set-ItemProperty -Path $Path -Name 'PromptOnSecureDesktop' -Type DWord -Value 1
	}

	If($SharingMappedDrives -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Sharing Mapped Drives between Users...' -C 15 }
	} ElseIf($SharingMappedDrives -eq 1) {
		DisplayOut 'Enabling Sharing Mapped Drives between Users...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections' -Type DWord -Value 1
	} ElseIf($SharingMappedDrives -eq 2) {
		DisplayOut 'Disabling Sharing Mapped Drives between Users...' -C 12
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections'
	}

	If($AdminShares -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Hidden Administrative Shares...' -C 15 }
	} ElseIf($AdminShares -eq 1) {
		DisplayOut 'Enabling Hidden Administrative Shares...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'AutoShareWks'
	} ElseIf($AdminShares -eq 2) {
		DisplayOut 'Disabling Hidden Administrative Shares...' -C 12
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'AutoShareWks' -Type DWord -Value 0
	}

	If($Firewall -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Firewall...' -C 15 }
	} ElseIf($Firewall -eq 1) {
		DisplayOut 'Enabling Firewall...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile' -Name 'EnableFirewall'
	} ElseIf($Firewall -eq 2) {
		DisplayOut 'Disabling Firewall...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile'
		Set-ItemProperty -Path $Path -Name 'EnableFirewall' -Type DWord -Value 0
	}

	If($WinDefender -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Defender...' -C 15 }
	} ElseIf($WinDefender -eq 1) {
		DisplayOut 'Enabling Windows Defender...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'DisableAntiSpyware'
		$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
		If($Win10Ver -lt 1703){ $RegName = 'WindowsDefender' } Else{ $RegName = 'SecurityHealth' }
		Set-ItemProperty -Path $Path -Name $RegName -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
		RemoveSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet'
	} ElseIf($WinDefender -eq 2) {
		DisplayOut 'Disabling Windows Defender...' -C 12
		$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
		If($Win10Ver -lt 1703){ $RegName = 'WindowsDefender' } Else{ $RegName = 'SecurityHealth' }
		Remove-ItemProperty -Path $Path -Name $RegName
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\'
		Set-ItemProperty -Path $Path -Name 'DisableAntiSpyware' -Type DWord -Value 1
		$Path = CheckSetPath "$Path\Spynet"
		Set-ItemProperty -Path $Path -Name 'SpynetReporting' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubmitSamplesConsent' -Type DWord -Value 2
	}

	If($HomeGroups -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Home Groups Services...' -C 15 }
	} ElseIf($HomeGroups -eq 1) {
		DisplayOut 'Enabling Home Groups Services...' -C 11
		Set-Service 'HomeGroupListener' -StartupType Manual
		Set-Service 'HomeGroupProvider' -StartupType Manual
		Start-Service 'HomeGroupProvider'
	} ElseIf($HomeGroups -eq 2) {
		DisplayOut 'Disabling Home Groups Services...' -C 12
		Stop-Service 'HomeGroupListener'
		Set-Service 'HomeGroupListener' -StartupType Disabled
		Stop-Service 'HomeGroupProvider'
		Set-Service 'HomeGroupProvider' -StartupType Disabled
	}

	If($RemoteAssistance -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Remote Assistance...' -C 15 }
	} ElseIf($RemoteAssistance -eq 1) {
		DisplayOut 'Enabling Remote Assistance...' -C 11
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Type DWord -Value 1
	} ElseIf($RemoteAssistance -eq 2) {
		DisplayOut 'Disabling Remote Assistance...' -C 12
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Type DWord -Value 0
	}

	If($RemoteDesktop -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Remote Desktop...' -C 15 }
	} ElseIf($RemoteDesktop -eq 1) {
		DisplayOut 'Enabling Remote Desktop w/o Network Level Authentication...' -C 11
		$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
		Set-ItemProperty -Path $Path -Name 'fDenyTSConnections' -Type DWord -Value 0
		Set-ItemProperty -Path "$Path\WinStations\RDP-Tcp" -Name 'UserAuthentication' -Type DWord -Value 0
	} ElseIf($RemoteDesktop -eq 2) {
		DisplayOut 'Disabling Remote Desktop...' -C 12
		$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
		Set-ItemProperty -Path $Path -Name 'fDenyTSConnections' -Type DWord -Value 1
		Set-ItemProperty -Path "$Path\WinStations\RDP-Tcp" -Name 'UserAuthentication' -Type DWord -Value 1
	}

	BoxItem 'Context Menu Items'
	If($CastToDevice -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Cast to Device Context item...' -C 15 }
	} ElseIf($CastToDevice -eq 1) {
		DisplayOut 'Enabling Cast to Device Context item...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' -Name '{7AD84985-87B4-4a16-BE58-8B72A5B390F7}'
	} ElseIf($CastToDevice -eq 2) {
		DisplayOut 'Disabling Cast to Device Context item...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked'
		Set-ItemProperty -Path $Path -Name '{7AD84985-87B4-4a16-BE58-8B72A5B390F7}' -Type String -Value 'Play to Menu'
	}

	If($PreviousVersions -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Previous Versions Context item...' -C 15 }
	} ElseIf($PreviousVersions -eq 1) {
		DisplayOut 'Enabling Previous Versions Context item...' -C 11
		New-Item -Path 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' | Out-Null
		New-Item -Path 'HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' | Out-Null
		New-Item -Path 'HKCR:\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' | Out-Null
		New-Item -Path 'HKCR:\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' | Out-Null
	} ElseIf($PreviousVersions -eq 2) {
		DisplayOut 'Disabling Previous Versions Context item...' -C 12
		RemoveSetPath 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
		RemoveSetPath 'HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
		RemoveSetPath 'HKCR:\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
		RemoveSetPath 'HKCR:\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
	}

	If($IncludeinLibrary -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Include in Library Context item...' -C 15 }
	} ElseIf($IncludeinLibrary -eq 1) {
		DisplayOut 'Enabling Include in Library Context item...' -C 11
		Set-ItemProperty -Path 'HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location' -Name '(Default)' -Type String -Value '{3dad6c5d-2167-4cae-9914-f99e41c12cfa}'
	} ElseIf($IncludeinLibrary -eq 2) {
		DisplayOut 'Disabling Include in Library...' -C 12
		Set-ItemProperty -Path 'HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location' -Name '(Default)' -Type String -Value ''
	}

	If($PinToStart -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Pin To Start Context item...' -C 15 }
	} ElseIf($PinToStart -eq 1) {
		DisplayOut 'Enabling Pin To Start Context item...' -C 11
		New-Item -Path 'HKCR:\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}' -Force | Out-Null
		New-Item -Path 'HKCR:\*\shellex\ContextMenuHandlers\{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}' -Force | Out-Null
		Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}' -Name '(Default)' -Type String -Value 'Taskband Pin'
		Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}' -Name '(Default)' -Type String -Value 'Start Menu Pin'
		Set-ItemProperty -Path 'HKCR:\Folder\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
		Set-ItemProperty -Path 'HKCR:\exefile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
		Set-ItemProperty -Path 'HKCR:\Microsoft.Website\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
		Set-ItemProperty -Path 'HKCR:\mscfile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
	} ElseIf($PinToStart -eq 2) {
		DisplayOut 'Disabling Pin To Start Context item...' -C 12
		Remove-Item -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}' -Force
		Remove-Item -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}' -Force
		Set-ItemProperty -Path 'HKCR:\Folder\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\exefile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\Microsoft.Website\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\mscfile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
	}

	If($PinToQuickAccess -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Pin To Quick Access Context item...' -C 15 }
	} ElseIf($PinToQuickAccess -eq 1) {
		DisplayOut 'Enabling Pin To Quick Access Context item...' -C 11
		$Path = CheckSetPath 'HKCR:\Folder\shell\pintohome'
		New-ItemProperty -Path $Path -Name 'MUIVerb' -Type String -Value '@shell32.dll,-51377'
		New-ItemProperty -Path $Path -Name 'AppliesTo' -Type String -Value 'System.ParsingName:<>"::{679f85cb-0220-4080-b29b-5540cc05aab6}" AND System.ParsingName:<>"::{645FF040-5081-101B-9F08-00AA002F954E}" AND System.IsFolder:=System.StructuredQueryType.Boolean#True'
		$Path = CheckSetPath  "$Path\command"
		New-ItemProperty -Path "$Path" -Name 'DelegateExecute' -Type String -Value '{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}'
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Classes\Folder\shell\pintohome'
		New-ItemProperty -Path $Path -Name 'MUIVerb' -Type String -Value '@shell32.dll,-51377'
		New-ItemProperty -Path $Path -Name 'AppliesTo' -Type String -Value 'System.ParsingName:<>"::{679f85cb-0220-4080-b29b-5540cc05aab6}" AND System.ParsingName:<>"::{645FF040-5081-101B-9F08-00AA002F954E}" AND System.IsFolder:=System.StructuredQueryType.Boolean#True'
		$Path = CheckSetPath  "$Path\command"
		New-ItemProperty -Path "$Path" -Name 'DelegateExecute' -Type String -Value '{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}'
	} ElseIf($PinToQuickAccess -eq 2) {
		DisplayOut 'Disabling Pin To Quick Access Context item...' -C 12
		RemoveSetPath 'HKCR:\Folder\shell\pintohome'
		RemoveSetPath 'HKLM:\SOFTWARE\Classes\Folder\shell\pintohome'
	}

	If($ShareWith -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Share With/Share Context item...' -C 15 }
	} ElseIf($ShareWith -eq 1) {
		DisplayOut 'Enabling Share With/Share Context item...' -C 11
		Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
		Set-ItemProperty -Path 'HKCR:\Directory\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
		Set-ItemProperty -Path 'HKCR:\Directory\shellex\CopyHookHandlers\Sharing' -Name '(Default)' -Type String -Value '{40dd6e20-7c17-11ce-a804-00aa003ca9f6}'
		Set-ItemProperty -Path 'HKCR:\Drive\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
		Set-ItemProperty -Path 'HKCR:\Directory\shellex\PropertySheetHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
		Set-ItemProperty -Path 'HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
		Set-ItemProperty -Path 'HKCR:\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
		Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\ModernSharing' -Name '(Default)' -Type String -Value '{e2bf9676-5f8f-435c-97eb-11607a5bedf7}'
	}  ElseIf($ShareWith -eq 2) {
		DisplayOut 'Disabling Share/Share With...' -C 12
		Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\Directory\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\Directory\shellex\CopyHookHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\Directory\shellex\PropertySheetHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\Drive\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -Path 'HKCR:\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
		Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\ModernSharing' -Name '(Default)' -Type String -Value ''
	}

	If($SendTo -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Send To Context item...' -C 15 }
	} ElseIf($SendTo -eq 1) {
		DisplayOut 'Enabling Send To Context item...' -C 11
		$Path = CheckSetPath 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo'
		Set-ItemProperty -Path $Path -Name '(Default)' -Type String -Value '{7BA4C740-9E81-11CF-99D3-00AA004AE837}' | Out-Null
	} ElseIf($SendTo -eq 2) {
		DisplayOut 'Disabling Send To Context item...' -C 12
		RemoveSetPath 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo'
	}

	BoxItem 'Task Bar Items'
	If($BatteryUIBar -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Battery UI Bar...' -C 15 }
	} ElseIf($BatteryUIBar -eq 1) {
		DisplayOut 'Enabling New Battery UI Bar...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell' -Name 'UseWin32BatteryFlyout'
	} ElseIf($BatteryUIBar -eq 2) {
		DisplayOut 'Enabling Old Battery UI Bar...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell'
		Set-ItemProperty -Path $Path -Name 'UseWin32BatteryFlyout' -Type DWord -Value 1
	}

	If($ClockUIBar -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Clock UI Bar...' -C 15 }
	} ElseIf($ClockUIBar -eq 1) {
		DisplayOut 'Enabling New Clock UI Bar...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell' -Name 'UseWin32TrayClockExperience'
	} ElseIf($ClockUIBar -eq 2) {
		DisplayOut 'Enabling Old Clock UI Bar...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell'
		Set-ItemProperty -Path $Path -Name 'UseWin32TrayClockExperience' -Type DWord -Value 1
	}

	If($VolumeControlBar -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Volume Control Bar...' -C 15 }
	} ElseIf($VolumeControlBar -eq 1) {
		DisplayOut 'Enabling New Volume Control Bar (Horizontal)...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC' -Name 'EnableMtcUvc'
	} ElseIf($VolumeControlBar -eq 2) {
		DisplayOut 'Enabling Classic Volume Control Bar (Vertical)...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC'
		Set-ItemProperty -Path $Path -Name 'EnableMtcUvc' -Type DWord -Value 0
	}

	If($TaskbarSearchBox -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar Search box / button...' -C 15 }
	} ElseIf($TaskbarSearchBox -eq 1) {
		DisplayOut 'Showing Taskbar Search box / button...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 1
	} ElseIf($TaskbarSearchBox -eq 2) {
		DisplayOut 'Hiding Taskbar Search box / button...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 0
	}

	If($TaskViewButton -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Task View button...' -C 15 }
	} ElseIf($TaskViewButton -eq 1) {
		DisplayOut 'Showing Task View button...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton'
	} ElseIf($TaskViewButton -eq 2) {
		DisplayOut 'Hiding Task View button...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Type DWord -Value 0
	}

	If($TaskbarIconSize -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Icon Size in Taskbar...' -C 15 }
	} ElseIf($TaskbarIconSize -eq 1) {
		DisplayOut 'Showing Normal Icon Size in Taskbar...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons'
	} ElseIf($TaskbarIconSize -eq 2) {
		DisplayOut 'Showing Smaller Icons in Taskbar...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' -Type DWord -Value 1
	}

	If($TaskbarGrouping -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar Item Grouping...' -C 15 }
	} ElseIf($TaskbarGrouping -eq 1) {
		DisplayOut 'Never Group Taskbar Items...' -C 14
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 2
	} ElseIf($TaskbarGrouping -eq 2) {
		DisplayOut 'Always Group Taskbar Items...' -C 14
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 0
	} ElseIf($TaskbarGrouping -eq 3) {
		DisplayOut 'When Needed Group Taskbar Items...' -C 14
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 1
	}

	If($TrayIcons -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Tray icons...' -C 15 }
	} ElseIf($TrayIcons -eq 1) {
		DisplayOut 'Hiding Tray Icons...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 1
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 1
	} ElseIf($TrayIcons -eq 2) {
		DisplayOut 'Showing All Tray Icons...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 0
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 0
	}

	If($SecondsInClock -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Seconds in Taskbar Clock...' -C 15 }
	} ElseIf($SecondsInClock -eq 1) {
		DisplayOut 'Showing Seconds in Taskbar Clock...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSecondsInSystemClock' -Type DWord -Value 1
	} ElseIf($SecondsInClock -eq 2) {
		DisplayOut 'Hiding Seconds in Taskbar Clock...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSecondsInSystemClock' -Type DWord -Value 0
	}

	If($LastActiveClick -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Last Active Click...' -C 15 }
	} ElseIf($LastActiveClick -eq 1) {
		DisplayOut 'Enabling Last Active Click...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LastActiveClick' -Type DWord -Value 1
	} ElseIf($LastActiveClick -eq 2) {
		DisplayOut 'Disabling Last Active Click...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LastActiveClick' -Type DWord -Value 0
	}

	If($TaskBarOnMultiDisplay -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar on Multiple Displays...' -C 15 }
	} ElseIf($TaskBarOnMultiDisplay -eq 1) {
		DisplayOut 'Showing Taskbar on Multiple Displays...' -C 11
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarEnabled' -Type DWord -Value 1
	} ElseIf($TaskBarOnMultiDisplay -eq 2) {
		DisplayOut 'Hiding Taskbar on Multiple Displays...' -C 12
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarEnabled' -Type DWord -Value 0
	}

	If($TaskbarButtOnDisplay -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar Buttons on Multiple Displays...' -C 15 }
	} ElseIf($TaskbarButtOnDisplay -eq 1) {
		DisplayOut 'Showing Taskbar Buttons on All Taskbars...' -C 14
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Type DWord -Value 0
	} ElseIf($TaskbarButtOnDisplay -eq 2) {
		DisplayOut 'Showing Taskbar Buttons on Taskbar where Window is open...' -C 14
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Type DWord -Value 2
	} ElseIf($TaskbarButtOnDisplay -eq 3) {
		DisplayOut 'Showing Taskbar Buttons on Main Taskbar and where Window is open...' -C 14
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Type DWord -Value 1
	}

	BoxItem 'Star Menu Items'
	If($StartMenuWebSearch -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Bing Search in Start Menu...' -C 15 }
	} ElseIf($StartMenuWebSearch -eq 1) {
		DisplayOut 'Enabling Bing Search in Start Menu...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled'
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'DisableWebSearch'
	} ElseIf($StartMenuWebSearch -eq 2) {
		DisplayOut 'Disabling Bing Search in Start Menu...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Type DWord -Value 0
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
		Set-ItemProperty -Path $Path -Name 'DisableWebSearch' -Type DWord -Value 1
	}

	If($StartSuggestions -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Start Menu Suggestions...' -C 15 }
	} ElseIf($StartSuggestions -eq 1) {
		DisplayOut 'Enabling Start Menu Suggestions...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
		Set-ItemProperty -Path $Path -Name 'ContentDeliveryAllowed' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'OemPreInstalledAppsEnabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEnabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEverEnabled' -Type DWord -Value 1
	 	Set-ItemProperty -Path $Path -Name 'SilentInstalledAppsEnabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SystemPaneSuggestionsEnabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'Start_TrackProgs' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-310093Enabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338387Enabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338388Enabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338389Enabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338393Enabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-358398Enabled' -Type DWord -Value 1
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-353696Enabled' -Type DWord -Value 1
	} ElseIf($StartSuggestions -eq 2) {
		DisplayOut 'Disabling Start Menu Suggestions...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
		Set-ItemProperty -Path $Path -Name 'ContentDeliveryAllowed' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'OemPreInstalledAppsEnabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEnabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEverEnabled' -Type DWord -Value 0
	 	Set-ItemProperty -Path $Path -Name 'SilentInstalledAppsEnabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SystemPaneSuggestionsEnabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'Start_TrackProgs' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-310093Enabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338387Enabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338388Enabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338389Enabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-338393Enabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-358398Enabled' -Type DWord -Value 0
		Set-ItemProperty -Path $Path -Name 'SubscribedContent-353696Enabled' -Type DWord -Value 0
		If($Win10Ver -ge 1803) {
			$key = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*windows.data.placeholdertilecollection\Current"
			Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $key.Data[0..15]
			Stop-Process -Name "ShellExperienceHost" -Force
		}
	}

	If($MostUsedAppStartMenu -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Most used Apps in Start Menu...' -C 15 }
	} ElseIf($MostUsedAppStartMenu -eq 1) {
		DisplayOut 'Showing Most used Apps in Start Menu...' -C 11
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackProgs' -Type DWord -Value 1
	} ElseIf($MostUsedAppStartMenu -eq 2) {
		DisplayOut 'Hiding Most used Apps in Start Menu...' -C 12
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackProgs' -Type DWord -Value 0
	}

	If($RecentItemsFrequent -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Recent Items and Frequent Places...' -C 15 }
	} ElseIf($RecentItemsFrequent -eq 1) {
		DisplayOut 'Enabling Recent Items and Frequent Places...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
		Set-ItemProperty -Path $Path -Name 'Start_TrackDocs' -Type DWord -Value 1
	} ElseIf($RecentItemsFrequent -eq 2) {
		DisplayOut 'Disabling Recent Items and Frequent Places...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
		Set-ItemProperty -Path $Path -Name 'Start_TrackDocs' -Type DWord -Value 0
	}

	BoxItem 'Explorer Items'
	If($PidInTitleBar -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Process ID on Title Bar...' -C 15 }
	} ElseIf($PidInTitleBar -eq 1) {
		DisplayOut 'Showing Process ID on Title Bar...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowPidInTitle' -Type DWord -Value 1
	} ElseIf($PidInTitleBar -eq 2) {
		DisplayOut 'Hiding Process ID on Title Bar...' -C 12
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowPidInTitle'
	}

	If($AeroSnap -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Aero Snap...' -C 15 }
	} ElseIf($AeroSnap -eq 1) {
		DisplayOut 'Enabling Aero Snap...' -C 11
		Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'WindowArrangementActive' -Type String -Value 1
	} ElseIf($AeroSnap -eq 2) {
		DisplayOut 'Disabling Aero Snap...' -C 12
		Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'WindowArrangementActive' -Type String -Value 0
	}

	If($AeroShake -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Aero Shake...' -C 15 }
	} ElseIf($AeroShake -eq 1) {
		DisplayOut 'Enabling Aero Shake...' -C 11
		Remove-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'NoWindowMinimizingShortcuts'
	} ElseIf($AeroShake -eq 2) {
		DisplayOut 'Disabling Aero Shake...' -C 12
		$Path = CheckSetPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer'
		Set-ItemProperty -Path $Path -Name 'NoWindowMinimizingShortcuts' -Type DWord -Value 1
	}

	If($KnownExtensions -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Known File Extensions...' -C 15 }
	} ElseIf($KnownExtensions -eq 1) {
		DisplayOut 'Showing Known File Extensions...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Type DWord -Value 0
	} ElseIf($KnownExtensions -eq 2) {
		DisplayOut 'Hiding Known File Extensions...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Type DWord -Value 1
	}

	If($HiddenFiles -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Hidden Files...' -C 15 }
	} ElseIf($HiddenFiles -eq 1) {
		DisplayOut 'Showing Hidden Files...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Type DWord -Value 1
	} ElseIf($HiddenFiles -eq 2) {
		DisplayOut 'Hiding Hidden Files...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Type DWord -Value 2
	}

	If($SystemFiles -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping System Files...' -C 15 }
	} ElseIf($SystemFiles -eq 1) {
		DisplayOut 'Showing System Files...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Type DWord -Value 1
	} ElseIf($SystemFiles -eq 2) {
		DisplayOut 'Hiding System fFiles...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Type DWord -Value 0
	}

	If($ExplorerOpenLoc -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Default Explorer view to Quick Access...' -C 15 }
	} ElseIf($ExplorerOpenLoc -eq 1) {
		DisplayOut 'Changing Default Explorer view to Quick Access...' -C 14
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo'
	} ElseIf($ExplorerOpenLoc -eq 2) {
		DisplayOut 'Changing Default Explorer view to This PC...' -C 14
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Type DWord -Value 1
	}

	If($RecentFileQikAcc -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Recent Files in Quick Access...' -C 15 }
	} ElseIf($RecentFileQikAcc -eq 1) {
		DisplayOut 'Showing Recent Files in Quick Access...' -C 11
		$Path = 'Microsoft\Windows\CurrentVersion\Explorer'
		Set-ItemProperty -Path "HKCU:\SOFTWARE\$Path" -Name 'ShowRecent' -Type DWord -Value 1
		Set-ItemProperty -Path "HKLM:\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" -Name '(Default)' -Type String -Value 'Recent Items Instance Folder'
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" -Name '(Default)' -Type String -Value 'Recent Items Instance Folder' }
	} ElseIf($RecentFileQikAcc -eq 2) {
		DisplayOut 'Hiding Recent Files in Quick Access...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Type DWord -Value 0
	} ElseIf($RecentFileQikAcc -eq 3) {
		DisplayOut 'Removing Recent Files in Quick Access...' -C 15
		$Path = 'Microsoft\Windows\CurrentVersion\Explorer'
		Set-ItemProperty -Path "HKCU:\SOFTWARE\$Path" -Name 'ShowRecent' -Type DWord -Value 0
		RemoveSetPath "HKLM:\SOFTWARE\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}"
		RemoveSetPath "HKLM:\SOFTWARE\Wow6432Node\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}"
	}

	If($FrequentFoldersQikAcc -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Frequent Folders in Quick Access...' -C 15 }
	} ElseIf($FrequentFoldersQikAcc -eq 1) {
		DisplayOut 'Showing Frequent Folders in Quick Access...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 1
	} ElseIf($FrequentFoldersQikAcc -eq 2) {
		DisplayOut 'Hiding Frequent Folders in Quick Access...' -C 12
		Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 0
	}

	If($WinContentWhileDrag -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Window Content while Dragging...' -C 15 }
	} ElseIf($WinContentWhileDrag -eq 1) {
		DisplayOut 'Showing Window Content while Dragging...' -C 11
		Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Type DWord -Value 1
	} ElseIf($WinContentWhileDrag -eq 2) {
		DisplayOut 'Hiding Window Content while Dragging...' -C 12
		Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Type DWord -Value 0
	}

	If($Autoplay -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Autoplay...' -C 15 }
	} ElseIf($Autoplay -eq 1) {
		DisplayOut 'Enabling Autoplay...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Type DWord -Value 0
	} ElseIf($Autoplay -eq 2) {
		DisplayOut 'Disabling Autoplay...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Type DWord -Value 1
	}

	If($Autorun -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Autorun for all Drives...' -C 15 }
	} ElseIf($Autorun -eq 1) {
		DisplayOut 'Enabling Autorun for all Drives...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoDriveTypeAutoRun'
	} ElseIf($Autorun -eq 2) {
		DisplayOut 'Disabling Autorun for all Drives...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
		Set-ItemProperty -Path $Path -Name 'NoDriveTypeAutoRun' -Type DWord -Value 255
	}

	If($StoreOpenWith -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Search Windows Store for Unknown Extensions...' -C 15 }
	} ElseIf($StoreOpenWith -eq 1) {
		DisplayOut 'Enabling Search Windows Store for Unknown Extensions...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'NoUseStoreOpenWith'
	} ElseIf($StoreOpenWith -eq 2) {
		DisplayOut 'Disabling Search Windows Store for Unknown Extensions...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
		Set-ItemProperty -Path $Path -Name 'NoUseStoreOpenWith' -Type DWord -Value 1
	}

	If($WinXPowerShell -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Win+X PowerShell to Command Prompt...' -C 15 }
	} ElseIf($WinXPowerShell -eq 1) {
		DisplayOut 'Changing Win+X Command Prompt to PowerShell...' -C 11
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DontUsePowerShellOnWinX' -Type DWord -Value 0
	} ElseIf($WinXPowerShell -eq 2) {
		DisplayOut 'Changing Win+X PowerShell to Command Prompt...' -C 12
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DontUsePowerShellOnWinX' -Type DWord -Value 1
	}

	If($TaskManagerDetails -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Task Manager Details...' -C 15 }
	} ElseIf($TaskManagerDetails -eq 1) {
		DisplayOut 'Attempting to Show Task Manager Details...' -C 11
		$Path =  'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager'
		$Taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
		$timeout = 30000
		$sleep = 100
		$Path =  'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager'
		Do {
			Start-Sleep -Milliseconds $sleep
			$timeout -= $sleep
			$TaskManKey = Get-ItemProperty -Path $Path -Name 'Preferences'
		} Until ($TaskManKey -or $timeout -le 0)
		Stop-Process $Taskmgr
		If($TaskManKey) {
			DisplayOut '----Showing Task Manager Details...' -C 11
			$TaskManKey.Preferences[28] = 0
			Set-ItemProperty -Path $Path -Name 'Preferences' -Type Binary -Value $TaskManKey.Preferences
		} Else {
			DisplayOut '----Unable to Show Task Manager Details...' -C 13
		}
	} ElseIf($TaskManagerDetails -eq 2) {
		DisplayOut 'Hiding Task Manager Details...' -C 12
		$Path = CheckSetPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager'
		$TaskManKey = Get-ItemProperty -Path $Path -Name 'Preferences'
		If($TaskManKey) {
			$TaskManKey.Preferences[28] = 1
			Set-ItemProperty -Path $Path -Name 'Preferences' -Type Binary -Value $TaskManKey.Preferences
		}
	}

	If($Win10Ver -ge 1709) {
		If($ReopenAppsOnBoot -eq 0) {
			If($ShowSkipped -eq 1){ DisplayOut 'Skipping Re-Opening Apps on Boot...' -C 15 }
		} ElseIf($ReopenAppsOnBoot -eq 1) {
			DisplayOut 'Enableing Re-Opening Apps on Boot (Apps reopen on boot)...' -C 11
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableAutomaticRestartSignOn' -Type DWord -Value 0
		} ElseIf($ReopenAppsOnBoot -eq 2) {
			DisplayOut "Disabling Re-Opening Apps on Boot (Apps won't reopen on boot)..." -C 12
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableAutomaticRestartSignOn' -Type DWord -Value 1
		}
	}

	If($Win10Ver -ge 1803) {
		If($Timeline -eq 0) {
			If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Timeline...' -C 15 }
		} ElseIf($Timeline -eq 1) {
			DisplayOut 'Enableing Windows Timeline...' -C 11
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -Type DWord -Value 1
		} ElseIf($Timeline -eq 2) {
			DisplayOut "Disabling Windows Timeline..." -C 12
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -Type DWord -Value 0
		}
	}

	If($LongFilePath -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Long File Path...' -C 15 }
	} ElseIf($LongFilePath -eq 1) {
		DisplayOut 'Enableing Long File Path...' -C 11
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Type DWord -Value 1
		Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\FileSystem' -Name 'LongPathsEnabled' -Type DWord -Value 1
	} ElseIf($LongFilePath -eq 2) {
		DisplayOut "Disabling Long File Path..." -C 12
		Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled'
		Remove-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\FileSystem' -Name 'LongPathsEnabled'
	}

	If($AppHibernationFile -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping App Hibernation File (Swapfile.sys)...' -C 15 }
	} ElseIf($AppHibernationFile -eq 1) {
		DisplayOut 'Enabling App Hibernation File (Swapfile.sys)...' -C 11
		Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl"
	} ElseIf($AppHibernationFile -eq 2) {
		DisplayOut 'Disabling App Hibernation File (Swapfile.sys)...' -C 12
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -Type Dword -Value 0
	}

	BoxItem "'This PC' Items"
	If($DesktopIconInThisPC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Desktop folder in This PC...' -C 15 }
	} ElseIf($DesktopIconInThisPC -eq 1) {
		DisplayOut 'Showing Desktop folder in This PC...' -C 11
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag'
		$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
		New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		If($OSBit -eq 64){
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		}
	} ElseIf($DesktopIconInThisPC -eq 2) {
		DisplayOut 'Hiding Desktop folder in This PC...' -C 12
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide' }
	} ElseIf($DesktopIconInThisPC -eq 3) {
		DisplayOut 'Removing Desktop folder in This PC...' -C 13
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
	}

	If($DocumentsIconInThisPC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Documents folder in This PC...' -C 15 }
	} ElseIf($DocumentsIconInThisPC -eq 1) {
		DisplayOut 'Showing Documents folder in This PC...' -C 11
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag'
		$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}'
		$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}'
		New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path2" | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'BaseFolderId' -Type String -Value '{FDD39AD0-238F-46AF-ADB4-6C85480369C7}'
		If($OSBit -eq 64){
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" | Out-Null
			Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" | Out-Null
		}
	}ElseIf($DocumentsIconInThisPC -eq 2) {
		DisplayOut 'Hiding Documents folder in This PC...' -C 12
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" }
	} ElseIf($DocumentsIconInThisPC -eq 3) {
		DisplayOut 'Removing Documents folder in This PC...' -C 13
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}'
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}'
	}

	If($DownloadsIconInThisPC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Downloads folder in This PC...' -C 15 }
	} ElseIf($DownloadsIconInThisPC -eq 1) {
		DisplayOut 'Showing Downloads folder in This PC...' -C 11
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag'
		$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}'
		$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}'
		New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path2" | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'BaseFolderId' -Type String -Value '{374DE290-123F-4565-9164-39C4925E467B}'
		If($OSBit -eq 64){
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path"
			Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" | Out-Null
		}
	} ElseIf($DownloadsIconInThisPC -eq 2) {
		DisplayOut 'Hiding Downloads folder in This PC...' -C 12
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" }
	} ElseIf($DownloadsIconInThisPC -eq 3) {
		DisplayOut 'Removing Downloads folder in This PC...' -C 13
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}'
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}'
	}

	If($MusicIconInThisPC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Music folder in This PC...' -C 15 }
	} ElseIf($MusicIconInThisPC -eq 1) {
		DisplayOut 'Showing Music folder in This PC...' -C 11
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag'
		$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}'
		$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}'
		New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path2" | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'BaseFolderId' -Type String -Value '{4BD8D571-6D19-48D3-BE97-422220080E43}'
		If($OSBit -eq 64){
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" | Out-Null
			Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" | Out-Null
		}
	} ElseIf($MusicIconInThisPC -eq 2) {
		DisplayOut 'Hiding Music folder in This PC...' -C 12
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide' }
	} ElseIf($MusicIconInThisPC -eq 3) {
		DisplayOut 'Removing Music folder in This PC...' -C 13
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}'
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}'
	}

	If($PicturesIconInThisPC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Pictures folder in This PC...' -C 15 }
	} ElseIf($PicturesIconInThisPC -eq 1) {
		DisplayOut 'Showing Pictures folder in This PC...' -C 11
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag'
		$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}'
		$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}'
		New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path2" | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'BaseFolderId' -Type String -Value '{33E28130-4E1E-4676-835A-98395C3BC3BB}'
		If($OSBit -eq 64){
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" | Out-Null
			Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" | Out-Null
		}
	} ElseIf($PicturesIconInThisPC -eq 2) {
		DisplayOut 'Hiding Pictures folder in This PC...' -C 12
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide' }
	} ElseIf($PicturesIconInThisPC -eq 3) {
		DisplayOut 'Removing Pictures folder in This PC...' -C 13
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}'
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}'
	}

	If($VideosIconInThisPC -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Videos folder in This PC...' -C 15 }
	} ElseIf($VideosIconInThisPC -eq 1) {
		DisplayOut 'Showing Videos folder in This PC...' -C 11
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag'
		$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}'
		$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}'
		New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\$Path2" | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'BaseFolderId' -Type String -Value '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}"'
		If($OSBit -eq 64){
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" | Out-Null
			Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" | Out-Null
		}
	} ElseIf($VideosIconInThisPC -eq 2) {
		DisplayOut 'Hiding Videos folder in This PC...' -C 12
		$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag'
		Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide"
		If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide' }
	} ElseIf($PicturesIconInThisPC -eq 3) {
		DisplayOut 'Removing Videos folder in This PC...' -C 13
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}'
		RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}'
		RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}'
	}

	If($Win10Ver -ge 1709){
		If($ThreeDobjectsIconInThisPC -eq 0) {
			If($ShowSkipped -eq 1){ DisplayOut 'Skipping 3D Object folder in This PC...' -C 15 }
		} ElseIf($ThreeDobjectsIconInThisPC -eq 1) {
			DisplayOut 'Showing 3D Object folder in This PC...' -C 11
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" | Out-Null
			New-Item -Path "HKLM:\SOFTWARE\$Path1" | Out-Null
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSBit -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" | Out-Null
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" | Out-Null
			}
		} ElseIf($ThreeDobjectsIconInThisPC -eq 2) {
			DisplayOut 'Hiding 3D Object folder in This PC...' -C 12
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSBit -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide' }
		} ElseIf($ThreeDobjectsIconInThisPC -eq 3) {
			DisplayOut 'Removing 3D Object folder in This PC...' -C 13
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
		}
	}

	BoxItem 'Desktop Items'
	$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
	If($ThisPCOnDesktop -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping This PC Icon on Desktop...' -C 15 }
	} ElseIf($ThisPCOnDesktop -eq 1) {
		DisplayOut 'Showing This PC Shortcut on Desktop...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
	} ElseIf($ThisPCOnDesktop -eq 2) {
		DisplayOut 'Hiding This PC Shortcut on Desktop...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 1
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 1
	}

	If($NetworkOnDesktop -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Network Icon on Desktop...' -C 15 }
	} ElseIf($NetworkOnDesktop -eq 1) {
		DisplayOut 'Showing Network Icon on Desktop...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 0
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 0
	} ElseIf($NetworkOnDesktop -eq 2) {
		DisplayOut 'Hiding Network Icon on Desktop...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 1
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 1
	}

	If($RecycleBinOnDesktop -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Recycle Bin Icon on Desktop...' -C 15 }
	} ElseIf($RecycleBinOnDesktop -eq 1) {
		DisplayOut 'Showing Recycle Bin Icon on Desktop...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 0
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 0
	} ElseIf($RecycleBinOnDesktop -eq 2) {
		DisplayOut 'Hiding Recycle Bin Icon on Desktop...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 1
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 1
	}

	If($UsersFileOnDesktop -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Users File Icon on Desktop...' -C 15 }
	} ElseIf($UsersFileOnDesktop -eq 1) {
		DisplayOut 'Showing Users File Icon on Desktop...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 0
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 0
	} ElseIf($UsersFileOnDesktop -eq 2) {
		DisplayOut 'Hiding Users File Icon on Desktop...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 1
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 1
	}

	If($ControlPanelOnDesktop -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Control Panel Icon on Desktop...' -C 15 }
	} ElseIf($ControlPanelOnDesktop -eq 1) {
		DisplayOut 'Showing Control Panel Icon on Desktop...' -C 11
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 0
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 0
	} ElseIf($ControlPanelOnDesktop -eq 2) {
		DisplayOut 'Hiding Control Panel Icon on Desktop...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
		Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 1
		Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 1
	}

	BoxItem 'Photo Viewer Settings'
	If($PVFileAssociation -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Photo Viewer File Association...' -C 15 }
	} ElseIf($PVFileAssociation -eq 1) {
		DisplayOut 'Setting Photo Viewer File Association for bmp, gif, jpg, png and tif...' -C 11
		ForEach($type In @('Paint.Picture', 'giffile', 'jpegfile', 'pngfile')) {
			New-Item -Path $("HKCR:\$type\shell\open") -Force | Out-Null
			New-Item -Path $("HKCR:\$type\shell\open\command") | Out-Null
			Set-ItemProperty -Path $("HKCR:\$type\shell\open") -Name 'MuiVerb' -Type ExpandString -Value "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3043"
			Set-ItemProperty -Path $("HKCR:\$type\shell\open\command") -Name '(Default)' -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
		}
	} ElseIf($PVFileAssociation -eq 2) {
		DisplayOut 'Unsetting Photo Viewer File Association for bmp, gif, jpg, png and tif...' -C 12
		RemoveSetPath 'HKCR:\Paint.Picture\shell\open'
		Remove-ItemProperty -Path 'HKCR:\giffile\shell\open' -Name 'MuiVerb'
		Set-ItemProperty -Path 'HKCR:\giffile\shell\open' -Name 'CommandId' -Type String -Value 'IE.File'
		Set-ItemProperty -Path 'HKCR:\giffile\shell\open\command' -Name '(Default)' -Type String -Value "`"$Env:SystemDrive\Program Files\Internet Explorer\iexplore.exe`" %1"
		Set-ItemProperty -Path 'HKCR:\giffile\shell\open\command' -Name 'DelegateExecute' -Type String -Value '{17FE9752-0B5A-4665-84CD-569794602F5C}'
		RemoveSetPath 'HKCR:\jpegfile\shell\open'
		RemoveSetPath 'HKCR:\jpegfile\shell\open'
	}

	If($PVOpenWithMenu -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Photo Viewer Open with Menu...' -C 15 }
	} ElseIf($PVOpenWithMenu -eq 1) {
		DisplayOut 'Adding Photo Viewer to Open with Menu...' -C 11
		New-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open\command' -Force | Out-Null
		New-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open\DropTarget' -Force | Out-Null
		Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open' -Name 'MuiVerb' -Type String -Value '@photoviewer.dll,-3043'
		Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open\command' -Name '(Default)' -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
		Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open\DropTarget' -Name 'Clsid' -Type String -Value '{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}'
	} ElseIf($PVOpenWithMenu -eq 2) {
		DisplayOut 'Removing Photo Viewer from Open with Menu...' -C 12
		RemoveSetPath 'HKCR:\Applications\photoviewer.dll\shell\open'
	}

	BoxItem 'Lockscreen Items'
	If($LockScreen -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Lock Screen...' -C 15 }
	} ElseIf($LockScreen -eq 1) {
		If($Win10Ver -In 1507,1511) {
			DisplayOut 'Enabling Lock Screen...' -C 11
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreen'
		} ElseIf($Win10Ver -ge 1607) {
			DisplayOut 'Enabling Lock screen (removing scheduler workaround)...' -C 11
			Unregister-ScheduledTask -TaskName 'Disable LockScreen' -Confirm:$False
		} Else {
			DisplayOut 'Unable to Enable Lock screen...' -C 13
		}
	} ElseIf($LockScreen -eq 2) {
		If($Win10Ver -In 1507,1511) {
			DisplayOut 'Disabling Lock Screen...' -C 12
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
			Set-ItemProperty -Path $Path -Name 'NoLockScreen' -Type DWord -Value 1
		} ElseIf($Win10Ver -ge 1607) {
			DisplayOut 'Disabling Lock screen using scheduler workaround...' -C 12
			$service = New-Object -com Schedule.Service
			$service.Connect()
			$task = $service.NewTask(0)
			$task.Settings.DisallowStartIfOnBatteries = $False
			$trigger = $task.Triggers.Create(9)
			$trigger = $task.Triggers.Create(11)
			$trigger.StateChange = 8
			$action = $task.Actions.Create(0)
			$action.Path = 'reg.exe'
			$action.Arguments = "add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData /t REG_DWORD /v AllowLockScreen /d 0 /f"
			$service.GetFolder('\').RegisterTaskDefinition('Disable LockScreen', $task, 6, 'NT AUTHORITY\SYSTEM', $null, 4) | Out-Null
		} Else {
			DisplayOut 'Unable to Disable Lock screen...' -C 13
		}
	}

	If($PowerMenuLockScreen -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Power Menu on Lock Screen...' -C 15 }
	} ElseIf($PowerMenuLockScreen -eq 1) {
		DisplayOut 'Showing Power Menu on Lock Screen...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'shutdownwithoutlogon' -Type DWord -Value 1
	} ElseIf($PowerMenuLockScreen -eq 2) {
		DisplayOut 'Hiding Power Menu on Lock Screen...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'shutdownwithoutlogon' -Type DWord -Value 0
	}

	If($CameraOnLockscreen -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Camera at Lockscreen...' -C 15 }
	} ElseIf($CameraOnLockscreen -eq 1) {
		DisplayOut 'Enabling Camera at Lockscreen...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreenCamera'
	} ElseIf($CameraOnLockscreen -eq 2) {
		DisplayOut 'Disabling Camera at Lockscreen...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
		Set-ItemProperty -Path $Path -Name 'NoLockScreenCamera' -Type DWord -Value 1
	}

	BoxItem 'Misc Items'
	If($Win10Ver -ge 1803) {
		If($AccountProtectionWarn -eq 0) {
			If($ShowSkipped -eq 1){ DisplayOut 'Skipping Account Protection Warning...' -C 15 }
		} ElseIf($AccountProtectionWarn -eq 1) {
			DisplayOut 'Enabling Account Protection Warning...' -C 11
			Remove-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows Security Health\State' -Name 'AccountProtection_MicrosoftAccount_Disconnected'
		} ElseIf($AccountProtectionWarn -eq 2) {
			DisplayOut 'Disabling Account Protection Warning...' -C 12
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows Security Health\State'
			Set-ItemProperty $Path -Name 'AccountProtection_MicrosoftAccount_Disconnected' -Type DWord -Value 1
		}
	}

	If($ActionCenter -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Action Center...' -C 15 }
	} ElseIf($ActionCenter -eq 1) {
		DisplayOut 'Enabling Action Center...' -C 11
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter'
		Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled'
	} ElseIf($ActionCenter -eq 2) {
		DisplayOut 'Disabling Action Center...' -C 12
		$Path = CheckSetPath 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
		Set-ItemProperty -Path $Path -Name 'DisableNotificationCenter' -Type DWord -Value 1
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Type DWord -Value 0
	}

	If($StickyKeyPrompt -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Sticky Key Prompt...' -C 15 }
	} ElseIf($StickyKeyPrompt -eq 1) {
		DisplayOut 'Enabling Sticky Key Prompt...' -C 11
		Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '510'
	} ElseIf($StickyKeyPrompt -eq 2) {
		DisplayOut 'Disabling Sticky Key Prompt...' -C 12
		Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '506'
	}

	If($NumblockOnStart -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Num Lock on Startup...' -C 15 }
	} ElseIf($NumblockOnStart -eq 1) {
		DisplayOut 'Enabling Num Lock on Startup...' -C 11
		Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2147483650
	} ElseIf($NumblockOnStart -eq 2) {
		DisplayOut 'Disabling Num Lock on Startup...' -C 12
		Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2147483648
	}

	If($F8BootMenu -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping F8 boot menu options...' -C 15 }
	} ElseIf($F8BootMenu -eq 1) {
		DisplayOut 'Enabling F8 boot menu options...' -C 11
		bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
	} ElseIf($F8BootMenu -eq 2) {
		DisplayOut 'Disabling F8 boot menu options...' -C 12
		bcdedit /set `{current`} bootmenupolicy Standard | Out-Null
	}

	If($RemoteUACAcctToken -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Remote UAC Local Account Token Filter...' -C 15 }
	} ElseIf($RemoteUACAcctToken -eq 1) {
		DisplayOut 'Enabling Remote UAC Local Account Token Filter...' -C 11
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LocalAccountTokenFilterPolicy' -Type DWord -Value 1
	} ElseIf($RemoteUACAcctToken -eq 2) {
		DisplayOut 'Disabling  Remote UAC Local Account Token Filter...' -C 12
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LocalAccountTokenFilterPolicy'
	}

	If($HibernatePower -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Hibernate Option...' -C 15 }
	} ElseIf($HibernatePower -eq 1) {
		DisplayOut 'Enabling Hibernate Option...' -C 11
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateEnabled' -Type DWord -Value 1
		powercfg /HIBERNATE ON
	} ElseIf($HibernatePower -eq 2) {
		DisplayOut 'Disabling Hibernate Option...' -C 12
		Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateEnabled' -Type DWord -Value 0
		powercfg /HIBERNATE OFF
	}

	If($SleepPower -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Sleep Option...' -C 15 }
	} ElseIf($SleepPower -eq 1) {
		DisplayOut 'Enabling Sleep Option...' -C 11
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings'
		Set-ItemProperty -Path $Path -Name 'ShowSleepOption' -Type DWord -Value 1
	} ElseIf($SleepPower -eq 2) {
		DisplayOut 'Disabling Sleep Option...' -C 12
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name 'ShowSleepOption' -Type DWord -Value 0
	}

	If($UnpinItems -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Unpinning Items...' -C 15 }
	} ElseIf($UnpinItems -eq 1) {
		DisplayOut "`nUnpinning All Startmenu Items..." -C 12
		If($Win10Ver -le 1709) {
			Get-ChildItem -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount" -Include "*.group" -Recurse | ForEach-Object {
				$data = (Get-ItemProperty -Path "$($_.PsPath)\Current" -Name "Data").Data -Join ","
				$data = $data.Substring(0, $data.IndexOf(",0,202,30") + 9) + ",0,202,80,0,0"
				Set-ItemProperty -Path "$($_.PsPath)\Current" -Name "Data" -Type Binary -Value $data.Split(",")
			}
		} Else {
			$key = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*start.tilegrid`$windows.data.curatedtilecollection.tilecollection\Current"
			$data = $key.Data[0..25] + ([byte[]](202,50,0,226,44,1,1,0,0))
			Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $data
			Stop-Process -Name "ShellExperienceHost" -Force
		}
	}

	If($DisableVariousTasks -eq 0) {
		#If($ShowSkipped -eq 1){ DisplayOut 'Skipping  Various Scheduled Tasks...' -C 15 }
	} ElseIf($DisableVariousTasks -eq 1) {
		DisplayOut "`nEnabling Various Scheduled Tasks...`n------------------" -C 12
		ForEach($TaskN in $TasksList){ Get-ScheduledTask -TaskName $TaskN | Enable-ScheduledTask }
	} ElseIf($DisableVariousTasks -eq 2) {
		DisplayOut "`nDisableing Various Scheduled Tasks...`n------------------" -C 12
		ForEach($TaskN in $TasksList){ Get-ScheduledTask -TaskName $TaskN | Disable-ScheduledTask }
	}

	BoxItem 'Application/Feature Items'
	If($OneDrive -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping OneDrive...' -C 15 }
	} ElseIf($OneDrive -eq 1) {
		DisplayOut 'Enabling OneDrive...' -C 11
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC'
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 1
	} ElseIf($OneDrive -eq 2) {
		DisplayOut 'Disabling OneDrive...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive'
		Set-ItemProperty -Path $Path -Name 'DisableFileSyncNGSC' -Type DWord -Value 1
		Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 0
	}

	If($OneDriveInstall -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping OneDrive Installing...' -C 15 }
	} ElseIf($OneDriveInstall -eq 1) {
		DisplayOut 'Installing OneDrive...' -C 11
		$onedriveS = "$Env:WINDIR\"
		If($OSBit -eq 64){ $onedriveS += 'SysWOW64' } Else{ $onedriveS += 'System32' }
		$onedriveS += '\OneDriveSetup.exe'
		If(Test-Path $onedriveS -PathType Leaf) { Start-Process $onedriveS -NoNewWindow }
	} ElseIf($OneDriveInstall -eq 2) {
		DisplayOut 'Uninstalling OneDrive...' -C 15
		$onedriveS = "$Env:WINDIR\"
		If($OSBit -eq 64){ $onedriveS += 'SysWOW64' } Else{ $onedriveS += 'System32' }
		$onedriveS += '\OneDriveSetup.exe'
		If(Test-Path $onedriveS -PathType Leaf) {
			Stop-Process -Name OneDrive -Force
			Start-Sleep -s 3
			Start-Process $onedriveS '/uninstall' -NoNewWindow -Wait | Out-Null
			Start-Sleep -s 3
			Stop-Process -Name Explorer -Force
			Start-Sleep -s 3
			Remove-Item "$Env:USERPROFILE\OneDrive" -Force -Recurse
			Remove-Item "$Env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
			Remove-Item "$Env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
			Remove-Item "$Env:WINDIR\OneDriveTemp" -Force -Recurse
			Remove-Item "$Env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
			Remove-Item -Path 'HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Recurse
			Remove-Item -Path 'HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Force -Recurse
		}
	}

	If($XboxDVR -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Xbox DVR...' -C 15 }
	} ElseIf($XboxDVR -eq 1) {
		DisplayOut 'Enabling Xbox DVR...' -C 11
		Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Type DWord -Value 1
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Name 'AllowGameDVR'
	} ElseIf($XboxDVR -eq 2) {
		DisplayOut 'Disabling Xbox DVR...' -C 12
		$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'
		Set-ItemProperty -Path $Path -Name 'AllowGameDVR' -Type DWord -Value 0
		Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Type DWord -Value 0
	}

	If($MediaPlayer -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Media Player...' -C 15 }
	} ElseIf($MediaPlayer -eq 1) {
		DisplayOut 'Installing Windows Media Player...' -C 11
		If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'MediaPlayback').State){ Enable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart | Out-Null }
	} ElseIf($MediaPlayer -eq 2) {
		DisplayOut 'Uninstalling Windows Media Player...' -C 14
		If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'MediaPlayback').State)){ Disable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart | Out-Null }
	}

	If($WorkFolders -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Work Folders Client...' -C 15 }
	} ElseIf($WorkFolders -eq 1) {
		DisplayOut 'Installing Work Folders Client...' -C 11
		If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'WorkFolders-Client').State){ Enable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart | Out-Null }
	} ElseIf($WorkFolders -eq 2) {
		DisplayOut 'Uninstalling Work Folders Client...' -C 14
		If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'WorkFolders-Client').State)){ Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart | Out-Null }
	}

	If($FaxAndScan -eq 0) {
		If($ShowSkipped -eq 1){ DisplayOut 'Skipping Fax And Scan...' -C 15 }
	} ElseIf($FaxAndScan -eq 1) {
		DisplayOut 'Installing Fax And Scan....' -C 11
		If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'FaxServicesClientPackage').State){ Enable-WindowsOptionalFeature -Online -FeatureName 'FaxServicesClientPackage' -NoRestart | Out-Null }
	} ElseIf($WFaxAndScan -eq 2) {
		DisplayOut 'Uninstalling Fax And Scan....' -C 14
		If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'FaxServicesClientPackage').State)){ Disable-WindowsOptionalFeature -Online -FeatureName 'FaxServicesClientPackage' -NoRestart | Out-Null }
	}

	If($Win10Ver -ge 1607) {
		If($LinuxSubsystem -eq 0) {
			If($ShowSkipped -eq 1){ DisplayOut 'Skipping Linux Subsystem...' -C 15 }
		} ElseIf($LinuxSubsystem -eq 1) {
			DisplayOut 'Installing Linux Subsystem...' -C 11
			If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'Microsoft-Windows-Subsystem-Linux').State){
				$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
				Set-ItemProperty -Path $Path -Name 'AllowDevelopmentWithoutDevLicense' -Type DWord -Value 1
				Set-ItemProperty -Path $Path -Name 'AllowAllTrustedApps' -Type DWord -Value 1
				Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Subsystem-Linux' -NoRestart | Out-Null
			}
		} ElseIf($LinuxSubsystem -eq 2) {
			DisplayOut 'Uninstalling Linux Subsystem...' -C 14
			If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'Microsoft-Windows-Subsystem-Linux').State)){
				$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
				Set-ItemProperty -Path $Path -Name 'AllowDevelopmentWithoutDevLicense' -Type DWord -Value 0
				Set-ItemProperty -Path $Path -Name 'AllowAllTrustedApps' -Type DWord -Value 0
				Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Subsystem-Linux' -NoRestart | Out-Null
			}
		}
	} ElseIf($LinuxSubsystem -ne 0) {
		DisplayOut "Windows 10 Build isn't new enough for Linux Subsystem..." -C 14
	}

	If($AppxCount -ne 0) {
		BoxItem 'Waiting for Appx Task to Finish'
		Wait-Job -Name "Win10Script*"
		Remove-Job -Name "Win10Script*"
	}

	If($Restart -eq 1 -And $Release_Type -eq 'Stable') {
		Clear-Host
		ThanksDonate
		$Seconds = 15
		DisplayOut "`nRestarting Computer in ",$Seconds,' Seconds...' -C 15,11,15
		$Message = 'Restarting in'
		Start-Sleep -Seconds 1
		ForEach($Count In (1..$Seconds)){ If($Count -ne 0){ DisplayOut $Message," $($Seconds - $Count)" -C 15,11 ;Start-Sleep -Seconds 1 } }
		DisplayOut 'Restarting Computer...' -C 13
		Restart-Computer
	} ElseIf($Release_Type -eq 'Stable') {
		DisplayOut 'Goodbye...' -C 13
		If($Automated -eq 0){ Read-Host -Prompt "`nPress any key to exit" }
		Exit
	} ElseIf($Automated -eq 0) {
		ThanksDonate
		Read-Host -Prompt "`nPress any key to Exit"
	}
}

##########
# Script -End
##########

# Used to get all values BEFORE any defined so
# when exporting shows ALL defined after this point
[System.Collections.ArrayList]$Script:WPFList = @()
$AutomaticVariables = Get-Variable -Scope Script

# DO NOT TOUCH THESE
$Script:AppsUnhide = ''
$Script:AppsHide = ''
$Script:AppsUninstall = ''

Function SetDefault {
#--------------------------------------------------------------------------
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!            SAFE TO EDIT VALUES             !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Edit values (Option) to your preference
# Change to an Option not listed will Skip the Function/Setting

# Note: If you're not sure what something does don't change it or do a web search

# Can ONLY create 1 per 24 hours with this script (Will give an error)
$Script:CreateRestorePoint = 0      #0-Skip, 1-Create --(Restore point before script runs)
$Script:RestorePointName = "Win10 Initial Setup Script"

#Skips Term of Use
$Script:AcceptToS = 1               #1-See ToS, Anything else = Accepts Term of Use
$Script:Automated = 0               #0-Pause at End/Error, Don't Pause at End/Error

$Script:ShowSkipped = 1             #0-Don't Show Skipped, 1-Show Skipped

#Update Related
$Script:VersionCheck = 0            #0-Don't Check for Update, 1-Check for Update (Will Auto Download and run newer version)
# Note: If found will Auto download and runs that, File name will be "Win10-Menu.ps1"

$Script:InternetCheck = 0           #0 = Checks if you have Internet by doing a ping to GitHub.com
                                    #1 = Bypass check if your pings are blocked

#Restart when done? (I recommend restarting when done)
$Script:Restart = 1                 #0-Don't Restart, 1-Restart

#Windows Default for ALL Settings
$Script:WinDefault = 2              #1-Yes*, 2-No
# IF 1 is set then Everything Other than the following will use the Default Win Settings
# ALL Values Above this one, All Metro Apps and OneDriveInstall (Will use what you set)

#Privacy Settings
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:Telemetry = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:WiFiSense = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:SmartScreen = 0             #0-Skip, 1-Enable*, 2-Disable --(phishing and malware filter for some MS Apps/Prog)
$Script:LocationTracking = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:Feedback = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:AdvertisingID = 0           #0-Skip, 1-Enable*, 2-Disable
$Script:Cortana = 0                 #0-Skip, 1-Enable*, 2-Disable
$Script:CortanaSearch = 0           #0-Skip, 1-Enable*, 2-Disable --(If you disable Cortana you can still search with this)
$Script:ErrorReporting = 0          #0-Skip, 1-Enable*, 2-Disable
$Script:AutoLoggerFile = 0          #0-Skip, 1-Enable*, 2-Disable
$Script:DiagTrack = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:WAPPush = 0                 #0-Skip, 1-Enable*, 2-Disable --(type of text message that contains a direct link to a particular Web page)

#Windows Update
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:CheckForWinUpdate = 0       #0-Skip, 1-Enable*, 2-Disable
$Script:WinUpdateType = 0           #0-Skip, 1-Notify, 2-Auto DL, 3-Auto DL+Install*, 4-Local admin chose --(May not work with Home version)
$Script:WinUpdateDownload = 0       #0-Skip, 1-P2P*, 2-Local Only, 3-Disable
$Script:UpdateMSRT = 0              #0-Skip, 1-Enable*, 2-Disable --(Malware Software Removal Tool)
$Script:UpdateDriver = 0            #0-Skip, 1-Enable*, 2-Disable --(Offering of drivers through Windows Update)
$Script:RestartOnUpdate = 0         #0-Skip, 1-Enable*, 2-Disable
$Script:AppAutoDownload = 0         #0-Skip, 1-Enable*, 2-Disable
$Script:UpdateAvailablePopup = 0    #0-Skip, 1-Enable*, 2-Disable

#Service Tweaks
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:UAC = 0                     #0-Skip, 1-Lower, 2-Normal*, 3-Higher
$Script:SharingMappedDrives = 0     #0-Skip, 1-Enable, 2-Disable* --(Sharing mapped drives between users)
$Script:AdminShares = 0             #0-Skip, 1-Enable*, 2-Disable --(Default admin shares for each drive)
$Script:Firewall = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:WinDefender = 0             #0-Skip, 1-Enable*, 2-Disable
$Script:HomeGroups = 0              #0-Skip, 1-Enable*, 2-Disable
$Script:RemoteAssistance = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:RemoteDesktop = 0           #0-Skip, 1-Enable, 2-Disable* --(Remote Desktop w/o Network Level Authentication)

#Context Menu Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:CastToDevice = 0            #0-Skip, 1-Enable*, 2-Disable
$Script:PreviousVersions = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:IncludeinLibrary = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:PinToStart = 0              #0-Skip, 1-Enable*, 2-Disable
$Script:PinToQuickAccess = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:ShareWith = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:SendTo = 0                  #0-Skip, 1-Enable*, 2-Disable

#Task Bar Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:BatteryUIBar = 0            #0-Skip, 1-New*, 2-Classic --(Classic is Win 7 version)
$Script:ClockUIBar = 0              #0-Skip, 1-New*, 2-Classic --(Classic is Win 7 version)
$Script:VolumeControlBar = 0        #0-Skip, 1-New(Horizontal)*, 2-Classic(Vertical) --(Classic is Win 7 version)
$Script:TaskbarSearchBox = 0        #0-Skip, 1-Show*, 2-Hide
$Script:TaskViewButton = 0          #0-Skip, 1-Show*, 2-Hide
$Script:TaskbarIconSize = 0         #0-Skip, 1-Normal*, 2-Smaller
$Script:TaskbarGrouping = 0         #0-Skip, 1-Never, 2-Always*, 3-When Needed
$Script:TrayIcons = 0               #0-Skip, 1-Auto*, 2-Always Show
$Script:SecondsInClock = 0          #0-Skip, 1-Show, 2-Hide*
$Script:LastActiveClick = 0         #0-Skip, 1-Enable, 2-Disable* --(Makes Taskbar Buttons Open the Last Active Window)
$Script:TaskBarOnMultiDisplay = 0   #0-Skip, 1-Enable*, 2-Disable
$Script:TaskBarButtOnDisplay = 0    #0-Skip, 1-All, 2-where window is open, 3-Main and where window is open

#Star Menu Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:StartMenuWebSearch = 0      #0-Skip, 1-Enable*, 2-Disable
$Script:StartSuggestions = 0        #0-Skip, 1-Enable*, 2-Disable --(The Suggested Apps in Start Menu)
$Script:MostUsedAppStartMenu = 0    #0-Skip, 1-Show*, 2-Hide
$Script:RecentItemsFrequent = 0     #0-Skip, 1-Enable*, 2-Disable --(In Start Menu)
$Script:UnpinItems = 0              #0-Skip, 1-Unpin

#Explorer Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:Autoplay = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:Autorun = 0                 #0-Skip, 1-Enable*, 2-Disable
$Script:PidInTitleBar = 0           #0-Skip, 1-Show, 2-Hide* --(PID = Processor ID)
$Script:AeroSnap = 0                #0-Skip, 1-Enable*, 2-Disable --(Allows you to quickly resize the window you’re currently using)
$Script:AeroShake = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:KnownExtensions = 0         #0-Skip, 1-Show, 2-Hide*
$Script:HiddenFiles = 0             #0-Skip, 1-Show, 2-Hide*
$Script:SystemFiles = 0             #0-Skip, 1-Show, 2-Hide*
$Script:ExplorerOpenLoc = 0         #0-Skip, 1-Quick Access*, 2-ThisPC --(What location it opened when you open an explorer window)
$Script:RecentFileQikAcc = 0        #0-Skip, 1-Show/Add*, 2-Hide, 3-Remove --(Recent Files in Quick Access)
$Script:FrequentFoldersQikAcc = 0   #0-Skip, 1-Show*, 2-Hide --(Frequent Folders in Quick Access)
$Script:WinContentWhileDrag = 0     #0-Skip, 1-Show*, 2-Hide
$Script:StoreOpenWith = 0           #0-Skip, 1-Enable*, 2-Disable
$Script:WinXPowerShell = 0          #0-Skip, 1-PowerShell*, 2-Command Prompt
$Script:TaskManagerDetails = 0      #0-Skip, 1-Show, 2-Hide*
$Script:ReopenAppsOnBoot = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:Timeline = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:LongFilePath = 0            #0-Skip, 1-Enable, 2-Disable*
$Script:AppHibernationFile = 0      #0-Skip, 1-Enable*, 2-Disable

#'This PC' Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:DesktopIconInThisPC = 0     #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:DocumentsIconInThisPC = 0   #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:DownloadsIconInThisPC = 0   #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:MusicIconInThisPC = 0       #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:PicturesIconInThisPC = 0    #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:VideosIconInThisPC = 0      #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:ThreeDobjectsIconInThisPC = 0   #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
# CAUTION: Removing them can cause problems

#Desktop Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:ThisPCOnDesktop = 0         #0-Skip, 1-Show, 2-Hide*
$Script:NetworkOnDesktop = 0        #0-Skip, 1-Show, 2-Hide*
$Script:RecycleBinOnDesktop = 0     #0-Skip, 1-Show, 2-Hide*
$Script:UsersFileOnDesktop = 0      #0-Skip, 1-Show, 2-Hide*
$Script:ControlPanelOnDesktop = 0   #0-Skip, 1-Show, 2-Hide*

#Lock Screen
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:LockScreen = 0              #0-Skip, 1-Enable*, 2-Disable
$Script:PowerMenuLockScreen = 0     #0-Skip, 1-Show*, 2-Hide
$Script:CameraOnLockScreen = 0      #0-Skip, 1-Enable*, 2-Disable

#Misc items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:AccountProtectionWarn = 0   #0-Skip, 1-Enable*, 2-Disable
$Script:ActionCenter = 0            #0-Skip, 1-Enable*, 2-Disable
$Script:StickyKeyPrompt = 0         #0-Skip, 1-Enable*, 2-Disable
$Script:NumblockOnStart = 0         #0-Skip, 1-Enable, 2-Disable*
$Script:F8BootMenu = 0              #0-Skip, 1-Enable, 2-Disable*
$Script:RemoteUACAcctToken = 0      #0-Skip, 1-Enable, 2-Disable*
$Script:HibernatePower = 0          #0-Skip, 1-Enable, 2-Disable --(Hibernate Power Option)
$Script:SleepPower = 0              #0-Skip, 1-Enable*, 2-Disable --(Sleep Power Option)
$Script:DisableVariousTasks = 0     #0-Skip, 1-Enable*, 2-Disable some scheduled tasks (This is NOT show in GUI)

# Photo Viewer Settings
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:PVFileAssociation = 0       #0-Skip, 1-Enable, 2-Disable*
$Script:PVOpenWithMenu = 0          #0-Skip, 1-Enable, 2-Disable*

# Application/Feature
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:OneDrive = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:OneDriveInstall = 0         #0-Skip, 1-Installed*, 2-Uninstall
$Script:XboxDVR = 0                 #0-Skip, 1-Enable*, 2-Disable
$Script:MediaPlayer = 0             #0-Skip, 1-Installed*, 2-Uninstall
$Script:WorkFolders = 0             #0-Skip, 1-Installed*, 2-Uninstall
$Script:FaxAndScan = 0              #0-Skip, 1-Installed*, 2-Uninstall
$Script:LinuxSubsystem = 0          #0-Skip, 1-Installed, 2-Uninstall* (Anniversary Update or Higher)

# Custom List of App to Install, Hide or Uninstall
# I dunno if you can Install random apps with this script
[System.Collections.ArrayList]$Script:APPS_AppsUnhide = @()         # Apps to Install
[System.Collections.ArrayList]$Script:APPS_AppsHide = @()           # Apps to Hide
[System.Collections.ArrayList]$Script:APPS_AppsUninstall = @()      # Apps to Uninstall
#$Script:APPS_Example = @('Somecompany.Appname1','TerribleCompany.Appname2','AppS.Appname3')
# To get list of Packages Installed (in PowerShell)
# DISM /Online /Get-ProvisionedAppxPackages | Select-string Packagename


# Metro Apps
# By Default Most of these are installed
# Function  = Option  # 0-Skip, 1-Unhide, 2- Hide, 3-Uninstall (!!Read Note Above)
$Script:APP_3DBuilder = 0           # 3DBuilder app
$Script:APP_3DViewer = 0            # 3DViewer app
$Script:APP_BingWeather = 0         # Bing Weather app
$Script:APP_CommsPhone = 0          # Phone app
$Script:APP_Communications = 0      # Calendar & Mail app
$Script:APP_GetHelp = 0             # Microsoft's Self-Help App
$Script:APP_Getstarted = 0          # Get Started link
$Script:APP_Messaging = 0           # Messaging app
$Script:APP_MicrosoftOffHub = 0     # Get Office Link
$Script:APP_MovieMoments = 0        # Movie Moments app
$Script:APP_Netflix = 0             # Netflix app
$Script:APP_OfficeOneNote = 0       # Office OneNote app
$Script:APP_OfficeSway = 0          # Office Sway app
$Script:APP_OneConnect = 0          # One Connect
$Script:APP_People = 0              # People app
$Script:APP_Photos = 0              # Photos app
$Script:APP_SkypeApp1 = 0           # Microsoft.SkypeApp
$Script:APP_SkypeApp2 = 0           # Microsoft.SkypeWiFi
$Script:APP_SolitaireCollect = 0    # Microsoft Solitaire
$Script:APP_StickyNotes = 0         # Sticky Notes app
$Script:APP_WindowsWallet = 0       # Stores Credit and Debit Card Information
$Script:APP_VoiceRecorder = 0       # Voice Recorder app
$Script:APP_WindowsAlarms = 0       # Alarms and Clock app
$Script:APP_WindowsCalculator = 0   # Calculator app
$Script:APP_WindowsCamera = 0       # Camera app
$Script:APP_WindowsFeedbak1 = 0     # Microsoft.WindowsFeedback
$Script:APP_WindowsFeedbak2 = 0     # Microsoft.WindowsFeedbackHub
$Script:APP_WindowsMaps = 0         # Maps app
$Script:APP_WindowsPhone = 0        # Phone Companion app
$Script:APP_WindowsStore = 0        # Windows Store
$Script:APP_XboxApp = 0             # Xbox apps (There is a few)
$Script:APP_ZuneMusic = 0           # Groove Music app
$Script:APP_ZuneVideo = 0           # Groove Video app
# --------------------------------------------------------------------------
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!        DO NOT EDIT PAST THIS POINT         !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
ScriptPreStart
