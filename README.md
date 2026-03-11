# Nexfuturo Consulting — Sitio Web

## Estructura del proyecto

```
nexfuturo/
│
├── index.html              ← Archivo principal (abrir en el navegador)
│
├── css/
│   ├── styles.css          ← Variables globales, reset, tipografía, botones
│   ├── navbar.css          ← Barra de navegación
│   ├── hero.css            ← Sección de inicio (hero)
│   ├── servicios.css       ← Sección de servicios
│   ├── planes.css          ← Sección de planes y precios
│   ├── nosotros-contacto.css ← Sección nosotros, contacto y footer
│   └── responsive.css      ← Adaptación para mobile y tablet
│
├── js/
│   ├── tabs.js             ← Lógica de los tabs de planes
│   ├── formulario.js       ← Validación y envío del formulario
│   └── animaciones.js      ← Scroll reveal y efectos visuales
│
└── img/
    ├── logo/               ← Logo de la empresa (PNG, SVG)
    ├── fotos/              ← Fotos del equipo, oficina, etc.
    └── icons/              ← Íconos adicionales si los usás
```

## Cómo usar en VS Code

1. Abrí la carpeta `nexfuturo/` en VS Code
2. Instalá la extensión **Live Server** (si no la tenés)
3. Click derecho en `index.html` → "Open with Live Server"
4. El sitio se abre en el navegador y se actualiza solo al guardar

## Personalización rápida

### Cambiar colores
Editá las variables en `css/styles.css`, sección `:root`:
- `--blue`: color principal (botones, acentos)
- `--accent`: color de destacado (cian)
- `--navy`: color de fondo

### Cambiar precios
Buscá en `index.html` los elementos con clase `.plan-price`

### Cambiar número de WhatsApp
Buscá en `index.html`: `https://wa.me/5491100000000`
Reemplazá con tu número real: `https://wa.me/549TUNUMERO`

### Agregar tu logo
Guardá el logo en `img/logo/logo.png` y en `index.html` 
reemplazá el texto del `.logo` por una etiqueta `<img>`

## Próximos pasos sugeridos

- [ ] Conectar formulario con EmailJS para recibir consultas por mail
- [ ] Agregar Google Analytics
- [ ] Subir a hosting (Netlify gratis, o Hostinger)
- [ ] Registrar dominio nexfuturo.com.ar
