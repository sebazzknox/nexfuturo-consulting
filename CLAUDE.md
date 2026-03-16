# Nexfuturo Consulting — Contexto del Proyecto

## Descripción
Sitio web de consultora de transformación digital para PyMEs argentinas.
Dueño del proyecto: Sebastian (IT Support Technician, Argentina).

## Estructura de archivos
```
nexfuturo/
├── index.html              ← página principal (NO modificar estructura HTML)
├── sistemas.html           ← página de sistemas a medida
├── css/
│   ├── styles.css          ← estilos globales, variables CSS, section padding
│   ├── navbar.css          ← navbar compartida entre index y sistemas
│   ├── hero.css
│   ├── servicios.css
│   ├── planes.css
│   ├── nosotros-contacto.css  ← sección nosotros + contacto
│   └── responsive.css
├── js/
│   ├── tabs.js
│   ├── formulario.js
│   ├── animaciones.js
│   ├── hero3d.js
│   └── three.min.js
└── CLAUDE.md
```

## Variables CSS globales (styles.css)
- `--navy: #0a0f1e`
- `--navy2: #101728`
- `--blue: #1a6fff`
- `--accent: #00e5ff`
- `--gray: #8a9bb8`
- `section { padding: 100px 6%; }` — aplica a TODAS las secciones

## Servicios y precios (ARS + IVA)
- **Diseño Web:** Landing $280k | Corporativa $450k | Tienda $680k
- **Automatizaciones:** Bot Básico $180k | Bot IA $350k | Full $520k
- **Redes Sociales:** $120k/mes | $220k/mes | $380k/mes
- **Soporte:** $35k/hora | $180k/mes | $320k/mes
- **Sistemas:** Turnos $450k+$80k/mes | Gimnasios $680k+$120k/mes | Catálogo $380k+$60k/mes | WA Pro $280k único

## Estado actual ✅
- Navbar idéntica en index y sistemas (carga css/navbar.css)
- Sección Nosotros alineada: `.why-visual` tiene `margin-top: 205px` y `align-self: stretch`
- sistemas.html con animaciones (partículas canvas, contadores, fade-in scroll, hover glow)
- Proyecto subido a GitHub

## Reglas importantes
- **NO modificar la estructura HTML de index.html** — solo CSS y JS
- Cambios de CSS siempre en el archivo correspondiente en css/
- El número de WhatsApp actual es placeholder: `5491100000000` → reemplazar por el real
- Dominio objetivo: nexfuturo.com.ar

## Pendientes
1. **EmailJS** — conectar formulario de contacto (campos: nombre, telefono, email, servicio, mensaje)
2. **Número de WhatsApp real** — reemplazar en index.html y sistemas.html
3. **Logo** — agregar imagen en img/logo/
4. **Hosting** — subir a servidor, registrar nexfuturo.com.ar
