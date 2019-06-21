@echo off
:: Version 1.1.1
:: June 21th, 2019

:: Instructions
:: Bat, Script, and setting MUST be in same Folder
:: Change Option to = one of the listed options (mostly yes or no)

set "Run_Option=0"
:: Anything other than following does nothing
:: 0 = Go to Script Menu
:: 1 = Run Script with settings in Script File
:: 2 = Run Script with Windows Default
:: 3 = Run Script with Your setting file (Change file name bellow)
:: 4 = Load Script with Windows Default (Does not run)
:: 5 = Load Script with Your setting file (Does not run)

:: Name of Script File
set "Script_File=Win10-Menu.ps1"

:: Name of setting File (Change Mine.csv to your setting file, if you have one)
set "setting_File=Mine.csv"

:: Change these to yes or no
set "Accept_ToS=no"
:: no = See ToS
:: yes = Skip ToS (You accepted it)

set "Create_Restore_Point=no"
set "Restore_Point_Name=Win10_Initial_setup_Script"

set "Restart_when_Done=yes"

:: Update Checks   
:: If update is found it will Auto-download and use that (with your settings)       
set "Script=no"
set "Internet_Check=yes" 
:: Internet_Check only matters If Script is yes and pings to github.com is blocked 

::----------------------------------------------------------------------
:: Do not change unless you know what you are doing
set "Script_Directory=%~dp0"
set "Script_Path=%Script_Directory%%Script_File%"

:: DO NOT CHANGE ANYTHING PAST THIS LINE
::----------------------------------------------------------------------
setlocal enableDelayedExpansion

if "%Run_Option%"=="1" (set Run_Option=!Run_Option! -run)
if "%Run_Option%"=="2" (set Run_Option=!Run_Option! -run wd)
if "%Run_Option%"=="3" (set Run_Option=!Run_Option! -run %setting_File%)
if "%Run_Option%"=="4" (set Run_Option=!Run_Option! -load wd)
if "%Run_Option%"=="5" (set Run_Option=!Run_Option! -load %setting_File%)

if /i "%Accept_ToS%"=="yes" (set Run_Option=!Run_Option! -atos)

if /i "%Create_Restore_Point%"=="yes" (set Run_Option=!Run_Option! -crp %Restore_Point_Name%)

if /i "%Internet_Check%"=="no" (set Run_Option=!Run_Option! -sic)

if /i "%Script%"=="yes" (set Run_Option=!Run_Option! -usc)

if /i "%Restart_when_Done%"=="no" (set Run_Option=!Run_Option! -dnr)

echo Running !Script_File!
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '!Script_Path!' !Run_Option!" -Verb RunAs
setlocal disableDelayedExpansion
