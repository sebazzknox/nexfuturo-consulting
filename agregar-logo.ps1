# ============================================================
#  NEXFUTURO — Agregar logo SVG al navbar
#  1. Copiá logo-nexfuturo.svg a la carpeta nexfuturo/img/
#  2. Ejecutá este script desde la carpeta nexfuturo/
#  powershell -ExecutionPolicy Bypass -File .\agregar-logo.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

# Crear carpeta img si no existe
if (-not (Test-Path "img")) { New-Item -ItemType Directory -Path "img" | Out-Null }

# Reemplazar en index.html
$index = Get-Content "index.html" -Raw -Encoding UTF8
$index = [regex]::Replace($index,
  'class="logo">[^<]+</a>',
  'class="logo"><img src="img/logo-nexfuturo.svg" alt="Nexfuturo Consulting" height="45" style="vertical-align:middle;"></a>'
)
[System.IO.File]::WriteAllText("$root\index.html", $index, [System.Text.Encoding]::UTF8)

# Reemplazar en sistemas.html
$sis = Get-Content "sistemas.html" -Raw -Encoding UTF8
$sis = [regex]::Replace($sis,
  'class="logo">[^<]+</a>',
  'class="logo"><img src="img/logo-nexfuturo.svg" alt="Nexfuturo Consulting" height="45" style="vertical-align:middle;"></a>'
)
[System.IO.File]::WriteAllText("$root\sistemas.html", $sis, [System.Text.Encoding]::UTF8)

Write-Host "OK - Logo agregado en ambas paginas. Recarga el navegador." -ForegroundColor Green
pause
