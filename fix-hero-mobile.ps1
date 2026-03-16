# ============================================================
#  NEXFUTURO — Fix hero mobile (stack columnas)
#  powershell -ExecutionPolicy Bypass -File .\fix-hero-mobile.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$css = Get-Content "css\hero.css" -Raw -Encoding UTF8

$fix = @"

/* ── FIX HERO MOBILE ── */
@media (max-width: 768px) {
  .hero {
    grid-template-columns: 1fr !important;
    padding: 100px 6% 60px;
    text-align: center;
  }

  .hero-content {
    max-width: 100%;
  }

  .hero-badge {
    margin: 0 auto 1.5rem;
  }

  .hero-buttons {
    justify-content: center;
  }

  .hero-stats {
    justify-content: center;
  }

  .hero-visual {
    height: 420px;
    margin-top: 0;
  }

  .phone-mockup {
    width: 220px;
    height: 430px;
  }

  .hero-tag-1, .hero-tag-2, .hero-tag-3 {
    font-size: 0.65rem;
    padding: 0.35rem 0.7rem;
  }

  .hero-tag-2 {
    right: 2%;
  }
}
"@

# Quitar fix anterior si existe
$css = [regex]::Replace($css, '(?s)/\* ── FIX HERO MOBILE ── \*/.*$', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
$css = $css.TrimEnd() + $fix

[System.IO.File]::WriteAllText("$root\css\hero.css", $css, [System.Text.Encoding]::UTF8)
Write-Host "OK - Hace git push y recarga en el celu." -ForegroundColor Green
pause
