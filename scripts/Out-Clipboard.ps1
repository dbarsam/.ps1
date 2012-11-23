## ===================================================================
##                          Out Clipboard
## ===================================================================
## File:           Out-Clipboard.ps1
## Purpose:        Sends the incoming output to the clipboard
## Author:         David Barsam
## URL:            https://github.com/dbarsam/.ps1
## ===================================================================
Param([string]$text)
Add-Type -AssemblyName System.Windows.Forms
$tb = New-Object System.Windows.Forms.TextBox
$tb.Multiline = $true

if ($Input -ne $null)
{
    $Input.Reset()
    $tb.Text = $Input | Out-String
}
else
{
    $tb.Text = $text
}
$tb.SelectAll()
$tb.Copy()

