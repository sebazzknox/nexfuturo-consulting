# ============================================================
#  NEXFUTURO — Fix sistemas.html responsive mobile
#  powershell -ExecutionPolicy Bypass -File .\fix-sistemas-mobile.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$sis = Get-Content "sistemas.html" -Raw -Encoding UTF8

# Agregar bloque de estilos mobile al final del <style> o antes del </head>
$mobileStyles = @"
<style>
@media (max-width: 768px) {

  /* Hero sistemas - stack vertical */
  .sis-hero,
  .sistemas-hero,
  [class*="hero"] {
    grid-template-columns: 1fr !important;
    flex-direction: column !important;
  }

  /* Cards sistemas - 1 columna */
  .sistemas-grid,
  .sis-grid,
  [class*="sistemas-grid"],
  [class*="sis-grid"] {
    grid-template-columns: 1fr !important;
  }

  /* WhatsApp Pro section - stack */
  .wa-pro-section,
  .wa-section,
  [class*="wa-pro"],
  [class*="whatsapp-section"] {
    grid-template-columns: 1fr !important;
    flex-direction: column !important;
  }

  /* Mockup chat - centrar y achicar */
  .wa-mockup,
  .chat-mockup,
  [class*="mockup"] {
    max-width: 300px !important;
    width: 100% !important;
    margin: 0 auto !important;
    position: relative !important;
    right: auto !important;
    left: auto !important;
    top: auto !important;
  }

  /* Navbar hamburguesa en sistemas */
  .nav-links {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 70px;
    left: 0;
    right: 0;
    background: #0a0f1e;
    padding: 20px;
    gap: 16px;
    z-index: 999;
    border-bottom: 1px solid rgba(26,111,255,0.2);
  }
  .nav-links.open { display: flex; }
  .nav-hamburger {
    display: flex !important;
    flex-direction: column;
    gap: 5px;
    cursor: pointer;
    padding: 8px;
  }
  .nav-hamburger span {
    display: block;
    width: 24px;
    height: 2px;
    background: white;
    border-radius: 2px;
  }
  nav { position: relative; }

  /* Proceso pasos - 2 columnas en mobile */
  .proceso-grid,
  [class*="proceso"],
  [class*="steps"] {
    grid-template-columns: repeat(2, 1fr) !important;
    gap: 16px !important;
  }

  /* Chips rubros - wrap */
  .rubros-grid,
  [class*="rubros"],
  [class*="chips"] {
    flex-wrap: wrap !important;
    justify-content: center !important;
  }
}
</style>
"@

# Agregar antes del </head>
if ($sis -notmatch "fix-sistemas-mobile") {
  $mobileStyles = $mobileStyles -replace '<style>', '<style>/* fix-sistemas-mobile */'
  $sis = $sis -replace '</head>', "$mobileStyles`n</head>"
}

# Agregar hamburguesa al nav si no existe
if ($sis -notmatch "nav-hamburger") {
  $sis = $sis -replace '(<nav[^>]*>)', '$1
    <div class="nav-hamburger" onclick="this.classList.toggle(''active''); document.querySelector(''.nav-links'').classList.toggle(''open'')">
      <span></span><span></span><span></span>
    </div>'
}

[System.IO.File]::WriteAllText("$root\sistemas.html", $sis, [System.Text.Encoding]::UTF8)
Write-Host "OK - Hace git push y recarga en el celu." -ForegroundColor Green
pause
