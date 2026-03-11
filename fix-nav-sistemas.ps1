# ============================================================
#  NEXFUTURO — Fix navbar sistemas.html (metodo regex)
#  powershell -ExecutionPolicy Bypass -File .\fix-nav-sistemas.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

Write-Host "Actualizando navbar de sistemas.html..." -ForegroundColor Cyan

$html = Get-Content "sistemas.html" -Raw -Encoding UTF8

# Reemplazar todo el bloque de links del nav con regex
$newLinks = '  <div class="sis-nav-links">
    <a href="index.html#servicios">Servicios</a>
    <a href="index.html#planes">Planes</a>
    <a href="index.html#testimonios">Testimonios</a>
    <a href="index.html#portfolio">Portfolio</a>
    <a href="sistemas.html" class="active">Digitaliz&#225; tu negocio</a>
    <a href="index.html#nosotros">Nosotros</a>
    <a href="index.html#contacto">Contacto</a>
  </div>
  <a href="https://wa.me/5491100000000" target="_blank" class="sis-nav-cta">Consult&#225; gratis</a>'

$html = [regex]::Replace($html, '(?s)<div class="sis-nav-links">.*?</div>\s*<a[^>]*sis-nav-cta[^>]*>.*?</a>', $newLinks)

[System.IO.File]::WriteAllText("$root\sistemas.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "  OK - Recarga el navegador." -ForegroundColor Green
pause
