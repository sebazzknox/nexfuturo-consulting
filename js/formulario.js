/* ============================================
   NEXFUTURO CONSULTING — Formulario de Contacto
   formulario.js
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {
  const btnSubmit = document.querySelector('.btn-submit');

  if (btnSubmit) {
    btnSubmit.addEventListener('click', enviarFormulario);
  }
});

/**
 * Maneja el envío del formulario de contacto.
 * Por ahora muestra una alerta. 
 * Más adelante se puede conectar a un backend o EmailJS.
 */
function enviarFormulario(e) {
  e.preventDefault();

  const nombre   = document.querySelector('input[placeholder="Tu nombre"]').value.trim();
  const telefono = document.querySelector('input[type="tel"]').value.trim();
  const email    = document.querySelector('input[type="email"]').value.trim();
  const servicio = document.querySelector('select').value;
  const mensaje  = document.querySelector('textarea').value.trim();

  // Validación básica
  if (!nombre || !email || !mensaje) {
    mostrarNotificacion('Por favor completá los campos obligatorios.', 'error');
    return;
  }

  if (!validarEmail(email)) {
    mostrarNotificacion('El email ingresado no es válido.', 'error');
    return;
  }

  // TODO: Conectar con EmailJS o backend propio
  console.log('Datos del formulario:', { nombre, telefono, email, servicio, mensaje });

  mostrarNotificacion('¡Gracias! Te respondemos en menos de 24hs.', 'exito');
  limpiarFormulario();
}

/**
 * Valida formato de email
 * @param {string} email
 * @returns {boolean}
 */
function validarEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}

/**
 * Limpia todos los campos del formulario
 */
function limpiarFormulario() {
  document.querySelectorAll('.contact-form input, .contact-form textarea, .contact-form select')
    .forEach(field => { field.value = ''; });
}

/**
 * Muestra una notificación temporal en pantalla
 * @param {string} mensaje - Texto a mostrar
 * @param {string} tipo - 'exito' o 'error'
 */
function mostrarNotificacion(mensaje, tipo) {
  // Remover notificación anterior si existe
  const anterior = document.querySelector('.notificacion');
  if (anterior) anterior.remove();

  const notif = document.createElement('div');
  notif.className = 'notificacion';
  notif.textContent = mensaje;
  notif.style.cssText = `
    position: fixed; bottom: 100px; right: 28px; z-index: 9999;
    padding: 1rem 1.5rem; border-radius: 10px;
    font-family: 'DM Sans', sans-serif; font-size: 0.9rem; font-weight: 600;
    background: ${tipo === 'exito' ? '#1a6fff' : '#e74c3c'};
    color: white; box-shadow: 0 8px 30px rgba(0,0,0,0.3);
    animation: fadeUp 0.3s ease;
  `;

  document.body.appendChild(notif);

  // Auto-remover después de 4 segundos
  setTimeout(() => { notif.remove(); }, 4000);
}
