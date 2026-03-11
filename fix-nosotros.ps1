# ============================================================
#  NEXFUTURO — Fix nosotros: reescribir seccion completa
#  powershell -ExecutionPolicy Bypass -File .\fix-nosotros.ps1
# ============================================================

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

Write-Host "Reescribiendo seccion nosotros en index.html..." -ForegroundColor Cyan

$html = Get-Content "index.html" -Raw -Encoding UTF8

$oldNosotros = '  <section id="nosotros">
    <div class="why-grid">
      <div>
        <span class="section-label">&#191;Por qu&#233; Nexfuturo?</span>
        <h2 class="section-title">T&#233;cnicos reales, resultados reales</h2>
        <p class="section-sub">No somos una agencia impersonal. Somos especialistas t&#233;cnicos que entienden tu negocio y te acompa&#241;an de principio a fin.</p>
        <div class="why-items">
          <div class="why-item">
            <div class="why-icon">&#127919;</div>
            <div>
              <h4>Enfoque en PyMEs locales</h4>
              <p>Sabemos lo que necesita un negocio chico: soluciones pr&#225;cticas, sin tecnicismos, con resultados visibles.</p>
            </div>
          </div>
          <div class="why-item">
            <div class="why-icon">&#9881;&#65039;</div>
            <div>
              <h4>Experiencia t&#233;cnica real</h4>
              <p>Combinamos soporte IT, desarrollo web y automatizaci&#243;n. Un solo proveedor para todas tus necesidades digitales.</p>
            </div>
          </div>
          <div class="why-item">
            <div class="why-icon">&#129309;</div>
            <div>
              <h4>Acompa&#241;amiento continuo</h4>
              <p>No desaparecemos despu&#233;s de entregar el proyecto. Estamos disponibles para ayudarte siempre que lo necesit&#233;s.</p>
            </div>
          </div>
        </div>
      </div>
      <div class="why-visual">
        <h3 style="font-family:''Sora'',sans-serif;font-size:1rem;font-weight:700;color:var(--gray);margin-bottom:0.5rem;">C&#211;MO TRABAJAMOS</h3>
        <div class="step">
          <div class="step-num">1</div>
          <div class="step-text">
            <h5>Diagn&#243;stico gratuito</h5>
            <p>Analizamos tu negocio y entendemos qu&#233; necesit&#225;s realmente.</p>
          </div>
        </div>
        <div class="step-arrow">&#8595;</div>
        <div class="step">
          <div class="step-num">2</div>
          <div class="step-text">
            <h5>Propuesta a medida</h5>
            <p>Te presentamos un plan claro con tiempos y precios definidos.</p>
          </div>
        </div>
        <div class="step-arrow">&#8595;</div>
        <div class="step">
          <div class="step-num">3</div>
          <div class="step-text">
            <h5>Desarrollo y entrega</h5>
            <p>Ejecutamos el proyecto con comunicaci&#243;n constante y transparente.</p>
          </div>
        </div>
        <div class="step-arrow">&#8595;</div>
        <div class="step">
          <div class="step-num">4</div>
          <div class="step-text">
            <h5>Soporte post-entrega</h5>
            <p>Te capacitamos y acompa&#241;amos para que todo funcione perfecto.</p>
          </div>
        </div>
      </div>
    </div>
  </section>'

$newNosotros = '  <section id="nosotros">
    <div class="why-header">
      <span class="section-label">&#191;Por qu&#233; Nexfuturo?</span>
      <h2 class="section-title">T&#233;cnicos reales, resultados reales</h2>
      <p class="section-sub">No somos una agencia impersonal. Somos especialistas t&#233;cnicos que entienden tu negocio y te acompa&#241;an de principio a fin.</p>
    </div>
    <div class="why-grid">
      <div class="why-items">
        <div class="why-item">
          <div class="why-icon">&#127919;</div>
          <div>
            <h4>Enfoque en PyMEs locales</h4>
            <p>Sabemos lo que necesita un negocio chico: soluciones pr&#225;cticas, sin tecnicismos, con resultados visibles.</p>
          </div>
        </div>
        <div class="why-item">
          <div class="why-icon">&#9881;&#65039;</div>
          <div>
            <h4>Experiencia t&#233;cnica real</h4>
            <p>Combinamos soporte IT, desarrollo web y automatizaci&#243;n. Un solo proveedor para todas tus necesidades digitales.</p>
          </div>
        </div>
        <div class="why-item">
          <div class="why-icon">&#129309;</div>
          <div>
            <h4>Acompa&#241;amiento continuo</h4>
            <p>No desaparecemos despu&#233;s de entregar el proyecto. Estamos disponibles para ayudarte siempre que lo necesit&#233;s.</p>
          </div>
        </div>
      </div>
      <div class="why-visual">
        <h3 style="font-family:''Sora'',sans-serif;font-size:1rem;font-weight:700;color:var(--gray);margin-bottom:0.5rem;">C&#211;MO TRABAJAMOS</h3>
        <div class="step">
          <div class="step-num">1</div>
          <div class="step-text">
            <h5>Diagn&#243;stico gratuito</h5>
            <p>Analizamos tu negocio y entendemos qu&#233; necesit&#225;s realmente.</p>
          </div>
        </div>
        <div class="step-arrow">&#8595;</div>
        <div class="step">
          <div class="step-num">2</div>
          <div class="step-text">
            <h5>Propuesta a medida</h5>
            <p>Te presentamos un plan claro con tiempos y precios definidos.</p>
          </div>
        </div>
        <div class="step-arrow">&#8595;</div>
        <div class="step">
          <div class="step-num">3</div>
          <div class="step-text">
            <h5>Desarrollo y entrega</h5>
            <p>Ejecutamos el proyecto con comunicaci&#243;n constante y transparente.</p>
          </div>
        </div>
        <div class="step-arrow">&#8595;</div>
        <div class="step">
          <div class="step-num">4</div>
          <div class="step-text">
            <h5>Soporte post-entrega</h5>
            <p>Te capacitamos y acompa&#241;amos para que todo funcione perfecto.</p>
          </div>
        </div>
      </div>
    </div>
  </section>'

$html = $html.Replace($oldNosotros, $newNosotros)

[System.IO.File]::WriteAllText("$root\index.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "  index.html actualizado" -ForegroundColor Green

# Actualizar CSS para .why-header y .why-grid sin margin-top
$css = Get-Content "css\nosotros-contacto.css" -Raw -Encoding UTF8

# Agregar .why-header si no existe
if ($css -notmatch '\.why-header') {
    $css = $css -replace '(\.why-grid \{)', ".why-header {
  margin-bottom: 48px;
}

`$1"
}

# Resetear why-grid para solo 2 columnas de items
$css = [regex]::Replace($css, '(?s)\.why-grid \{[^}]+\}', '.why-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 32px;
  align-items: start;
}')

# Resetear why-items sin margin-top
$css = [regex]::Replace($css, '(?s)\.why-items \{[^}]+\}', '.why-items {
  display: flex;
  flex-direction: column;
  gap: 16px;
}')

# Resetear why-visual sin margin-top negativo
$css = [regex]::Replace($css, '(?s)\.why-visual \{[^}]+\}', '.why-visual {
  background: rgba(10,20,40,0.6);
  border: 1px solid rgba(26,111,255,0.15);
  border-radius: 20px;
  padding: 32px;
  align-self: start;
}')

[System.IO.File]::WriteAllText("$root\css\nosotros-contacto.css", $css, [System.Text.Encoding]::UTF8)
Write-Host "  CSS actualizado" -ForegroundColor Green
Write-Host "  Listo! Recarga el navegador." -ForegroundColor Cyan
pause
