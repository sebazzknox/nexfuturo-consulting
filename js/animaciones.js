/* ============================================
   NEXFUTURO CONSULTING — Animaciones & Scroll
   animaciones.js
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {
  iniciarAnimacionesScroll();
  iniciarNavbarScroll();
});

/**
 * Anima elementos cuando entran al viewport (scroll reveal)
 */
function iniciarAnimacionesScroll() {
  const elementos = document.querySelectorAll(
    '.service-card, .plan-card, .why-item, .step'
  );

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry, index) => {
      if (entry.isIntersecting) {
        // Delay escalonado para que aparezcan uno por uno
        setTimeout(() => {
          entry.target.style.opacity = '1';
          entry.target.style.transform = 'translateY(0)';
        }, index * 80);
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  elementos.forEach(el => {
    // Estado inicial: invisible y desplazado
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    observer.observe(el);
  });
}

/**
 * Cambia el estilo del navbar al hacer scroll
 */
function iniciarNavbarScroll() {
  const navbar = document.querySelector('nav');
  if (!navbar) return;

  window.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
      navbar.style.background = 'rgba(10, 15, 30, 0.97)';
    } else {
      navbar.style.background = 'rgba(10, 15, 30, 0.85)';
    }
  });
}
