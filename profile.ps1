## ===================================================================
##                    Windows PowerShell Profile
## ===================================================================
## File:           profile.ps1
## Purpose:        Default profile for Microsoft PowerShell
## Author:         David Barsam
## URL:            https://github.com/dbarsam/.ps1
## ===================================================================

## ===================================================================
## Security Settings
Set-ExecutionPolicy RemoteSigned

## ===================================================================
## Environment Variables
$ProfileDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptDir  = "$ProfileDir\scripts"
$ModuleDir  = "$ProfileDir\modules"

## ===================================================================
## PS Drives
if (!(Test-Path -Path $ScriptDir ))
{
    New-Item -ItemType Directory -Path $ScriptDir  | Out-Null
}
New-PSdrive -name Scripts -PSprovider filesystem -root $ScriptDir
if (!(Test-Path -Path $ModuleDir ))
{
    New-Item -ItemType Directory -Path $ModuleDir | Out-Null
}
New-PSdrive -name Modules -PSprovider filesystem -root $ModuleDir

## ===================================================================
## Quick Functions
function global:Append-Path([string] $path) 
{
    if ( -not [string]::IsNullOrEmpty($path) -and (test-path $path) -and (-not $env:PATH.contains($path)) ) 
    {
        $env:PATH += ';' + $path
    }
}

function global:Get-Path() 
{
    return $ENV:PATH 
}

function global:Get-PathList()
{
    return $ENV:Path.Replace('"', '').Split(';') | Sort-Object -unique
}

function global:Get-Version([string] $file)
{
    (Get-Command $file).FileVersionInfo
}

function global:Start-Explorer([string] $loc = '.')
{
    explorer "/e,"$loc"" 
}

## ===================================================================
## Append the Path Environment
Append-Path "$ScriptDir"
Append-Path "$ModuleDir"

## ===================================================================
## Alias
set-alias ex Start-Explorer
