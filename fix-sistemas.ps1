# ============================================================
#  NEXFUTURO — Fix caracteres sistemas.html
#  powershell -ExecutionPolicy Bypass -File .\fix-sistemas.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

Write-Host "Corrigiendo caracteres en sistemas.html..." -ForegroundColor Cyan

$html = Get-Content "sistemas.html" -Raw -Encoding UTF8

# Corregir entidades HTML que quedaron escapadas
$html = $html -replace '&amp;#10003;', '&#10003;'
$html = $html -replace '&amp;#128197;', '&#128197;'
$html = $html -replace '&amp;#127947;', '&#127947;'
$html = $html -replace '&amp;#128230;', '&#128230;'
$html = $html -replace '&amp;#128172;', '&#128172;'
$html = $html -replace '&amp;#128640;', '&#128640;'
$html = $html -replace '&amp;#128075;', '&#128075;'
$html = $html -replace '&amp;#128197;', '&#128197;'
$html = $html -replace '&amp;#10004;', '&#10004;'
$html = $html -replace '&amp;#65039;', '&#65039;'
$html = $html -replace '&amp;#8419;', '&#8419;'
$html = $html -replace '&amp;mdash;', '&mdash;'
$html = $html -replace '&amp;bull;', '&bull;'
$html = $html -replace '&amp;#8226;', '&#8226;'
$html = $html -replace '&amp;#225;', '&#225;'
$html = $html -replace '&amp;#243;', '&#243;'
$html = $html -replace '&amp;#233;', '&#233;'
$html = $html -replace '&amp;#241;', '&#241;'
$html = $html -replace '&amp;#191;', '&#191;'
$html = $html -replace '&amp;#161;', '&#161;'

# Por si acaso quedaron sin el amp
$html = $html -replace '&#10003;;', '&#10003;'

[System.IO.File]::WriteAllText("$root\sistemas.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "  OK - Recarga el navegador en sistemas.html" -ForegroundColor Green
pause
