# ============================================================
#  NEXFUTURO — Fix nosotros: sin animacion + altura completa
#  powershell -ExecutionPolicy Bypass -File .\fix-nosotros-final.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$css = Get-Content "css\nosotros-contacto.css" -Raw -Encoding UTF8

# why-grid con stretch para que el visual ocupe toda la altura del lado izquierdo
$css = [regex]::Replace($css, '(?s)\.why-grid\s*\{[^}]+\}', '.why-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: start;
  max-width: 1100px;
  margin: 0 auto;
}')

# why-visual: margin-top exacto, sin animacion, height stretch
$css = [regex]::Replace($css, '(?s)\.why-visual\s*\{[^}]+\}', '.why-visual {
  background: rgba(10,20,40,0.6);
  border: 1px solid rgba(26,111,255,0.15);
  border-radius: 20px;
  padding: 32px;
  margin-top: 205px;
  align-self: stretch;
}')

# Limpiar animaciones flotantes previas
$css = [regex]::Replace($css, '(?s)@keyframes floatPanel\s*\{[^}]+\}', '')

[System.IO.File]::WriteAllText("$root\css\nosotros-contacto.css", $css, [System.Text.Encoding]::UTF8)
Write-Host "OK - Recarga el navegador." -ForegroundColor Green
pause
