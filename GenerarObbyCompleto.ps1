# ============================================================
#  NEXFUTURO — Fix responsive mobile
#  powershell -ExecutionPolicy Bypass -File .\fix-responsive.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$css = Get-Content "css\responsive.css" -Raw -Encoding UTF8

# Agregar fixes al final
$fixes = @"

/* ── FIX MOBILE HERO ── */
@media (max-width: 768px) {
  .hero-content {
    grid-template-columns: 1fr !important;
    text-align: center;
  }

  .hero-text {
    order: 1;
  }

  .hero-visual {
    order: 2;
    display: flex;
    justify-content: center;
    margin-top: 32px;
  }

  .hero-mockup {
    max-width: 280px;
    width: 100%;
  }

  .hero-buttons {
    justify-content: center;
    flex-wrap: wrap;
  }

  .hero-badge {
    margin: 0 auto;
  }

  /* Navbar hamburguesa */
  .nav-links {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 70px;
    left: 0;
    right: 0;
    background: var(--navy);
    padding: 20px;
    gap: 16px;
    z-index: 999;
    border-bottom: 1px solid rgba(26,111,255,0.2);
  }

  .nav-links.open {
    display: flex;
  }

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
    transition: 0.3s;
  }

  nav {
    position: relative;
  }
}
"@

# Quitar fix anterior si existe
$css = [regex]::Replace($css, '(?s)/\* ── FIX MOBILE HERO ── \*/.*$', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
$css = $css.TrimEnd() + $fixes

[System.IO.File]::WriteAllText("$root\css\responsive.css", $css, [System.Text.Encoding]::UTF8)

# Agregar boton hamburguesa al navbar en index.html
$index = Get-Content "index.html" -Raw -Encoding UTF8

if ($index -notmatch "nav-hamburger") {
  $index = $index -replace '(<nav[^>]*>)', '$1
    <div class="nav-hamburger" onclick="this.classList.toggle(''active''); document.querySelector(''.nav-links'').classList.toggle(''open'')">
      <span></span><span></span><span></span>
    </div>'
  [System.IO.File]::WriteAllText("$root\index.html", $index, [System.Text.Encoding]::UTF8)
}

Write-Host "OK - Hace git push y recarga en el celu." -ForegroundColor Green
pause
