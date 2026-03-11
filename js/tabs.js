/* ============================================
   NEXFUTURO CONSULTING — Tabs de Planes
   tabs.js
   ============================================ */

/**
 * Muestra el contenido del tab seleccionado
 * y marca el botón como activo.
 * @param {string} tabId - ID del tab (ej: 'web', 'auto', 'redes', 'soporte')
 * @param {HTMLElement} btnClicked - El botón que fue clickeado
 */
function showTab(tabId, btnClicked) {
  // Ocultar todos los tabs
  document.querySelectorAll('.plan-section').forEach(section => {
    section.classList.remove('active');
  });

  // Desactivar todos los botones
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.remove('active');
  });

  // Mostrar el tab seleccionado
  const targetTab = document.getElementById('tab-' + tabId);
  if (targetTab) {
    targetTab.classList.add('active');
  }

  // Activar el botón clickeado
  if (btnClicked) {
    btnClicked.classList.add('active');
  }
}

// Inicializar: mostrar el primer tab al cargar la página
document.addEventListener('DOMContentLoaded', () => {
  const firstBtn = document.querySelector('.tab-btn');
  if (firstBtn) {
    showTab('web', firstBtn);
  }
});
