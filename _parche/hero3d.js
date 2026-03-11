/* ============================================
   NEXFUTURO CONSULTING — Animación 3D Hero
   hero3d.js — requiere Three.js r128
============================================ */
(function () {
  const CONFIG = {
    particleCount: 1800,
    orbitSpeed:    0.0018,
    sphereRadius:  2.2,
    primaryColor:  0x1a6fff,
    accentColor:   0x00e5ff,
    glowColor:     0x3d8bff,
  };

  const container = document.getElementById('hero3d');
  if (!container) return;

  const W = container.clientWidth  || 500;
  const H = container.clientHeight || 500;

  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
  renderer.setSize(W, H);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.setClearColor(0x000000, 0);
  container.appendChild(renderer.domElement);

  const scene  = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(60, W / H, 0.1, 100);
  camera.position.set(0, 0, 6.5);

  // Esfera de partículas
  const sphereGeo       = new THREE.BufferGeometry();
  const spherePositions = [];
  const sphereSizes     = [];
  for (let i = 0; i < CONFIG.particleCount; i++) {
    const phi   = Math.acos(1 - 2 * (i / CONFIG.particleCount));
    const theta = Math.PI * (1 + Math.sqrt(5)) * i;
    const r     = CONFIG.sphereRadius + (Math.random() - 0.5) * 0.3;
    spherePositions.push(
      r * Math.sin(phi) * Math.cos(theta),
      r * Math.sin(phi) * Math.sin(theta),
      r * Math.cos(phi)
    );
    sphereSizes.push(Math.random() * 2.5 + 0.8);
  }
  sphereGeo.setAttribute('position', new THREE.Float32BufferAttribute(spherePositions, 3));
  sphereGeo.setAttribute('size',     new THREE.Float32BufferAttribute(sphereSizes, 1));

  const sphereMat = new THREE.ShaderMaterial({
    uniforms: {
      uTime:         { value: 0 },
      uColorPrimary: { value: new THREE.Color(CONFIG.primaryColor) },
      uColorAccent:  { value: new THREE.Color(CONFIG.accentColor)  },
    },
    vertexShader: `
      attribute float size;
      uniform float uTime;
      varying float vDist;
      void main() {
        vDist = length(position) / 2.5;
        vec3 pos = position;
        float pulse = sin(uTime * 1.2 + length(position) * 0.8) * 0.04;
        pos *= (1.0 + pulse);
        vec4 mvPos = modelViewMatrix * vec4(pos, 1.0);
        gl_PointSize = size * (280.0 / -mvPos.z);
        gl_Position  = projectionMatrix * mvPos;
      }
    `,
    fragmentShader: `
      uniform vec3 uColorPrimary;
      uniform vec3 uColorAccent;
      varying float vDist;
      void main() {
        float d = length(gl_PointCoord - 0.5) * 2.0;
        if (d > 1.0) discard;
        float alpha = smoothstep(1.0, 0.0, d) * 0.9;
        vec3 col = mix(uColorAccent, uColorPrimary, vDist);
        gl_FragColor = vec4(col, alpha);
      }
    `,
    transparent: true,
    depthWrite:  false,
    blending:    THREE.AdditiveBlending,
  });
  const sphereParticles = new THREE.Points(sphereGeo, sphereMat);
  scene.add(sphereParticles);

  // Wireframe núcleo
  const wire = new THREE.Mesh(
    new THREE.SphereGeometry(0.58, 12, 12),
    new THREE.MeshBasicMaterial({ color: CONFIG.accentColor, wireframe: true, transparent: true, opacity: 0.25 })
  );
  scene.add(wire);

  // Anillos orbitales
  const ringConfigs = [
    { radius: 2.8, tube: 0.012, tilt: [0.4, 0, 0],   speed:  0.006,  color: CONFIG.accentColor,  opacity: 0.6  },
    { radius: 3.2, tube: 0.009, tilt: [0, 0.6, 0.3], speed: -0.004,  color: CONFIG.primaryColor, opacity: 0.45 },
    { radius: 3.6, tube: 0.007, tilt: [0.8, 0.2, 0], speed:  0.003,  color: CONFIG.glowColor,    opacity: 0.3  },
  ];
  const rings = ringConfigs.map(cfg => {
    const ring = new THREE.Mesh(
      new THREE.TorusGeometry(cfg.radius, cfg.tube, 8, 120),
      new THREE.MeshBasicMaterial({ color: cfg.color, transparent: true, opacity: cfg.opacity })
    );
    ring.rotation.set(...cfg.tilt);
    ring.userData.speed = cfg.speed;
    scene.add(ring);
    return ring;
  });

  // Partículas orbitales
  const orbitPos  = [];
  const orbitData = [];
  ringConfigs.forEach((cfg, r) => {
    const count = 18 + r * 6;
    for (let i = 0; i < count; i++) {
      const angle = (i / count) * Math.PI * 2;
      orbitPos.push(Math.cos(angle) * cfg.radius, 0, Math.sin(angle) * cfg.radius);
      orbitData.push({ angle, radius: cfg.radius, ring: r });
    }
  });
  const orbitGeo = new THREE.BufferGeometry();
  orbitGeo.setAttribute('position', new THREE.Float32BufferAttribute(orbitPos, 3));
  scene.add(new THREE.Points(orbitGeo, new THREE.PointsMaterial({
    color: CONFIG.accentColor, size: 0.08, transparent: true,
    opacity: 0.8, blending: THREE.AdditiveBlending, depthWrite: false,
  })));

  // Líneas de grilla
  const gridLines = [];
  for (let i = 0; i < 8; i++) {
    const pts = [];
    const theta = (i / 8) * Math.PI * 2;
    for (let j = 0; j <= 30; j++) {
      const phi = (j / 30) * Math.PI;
      pts.push(new THREE.Vector3(
        CONFIG.sphereRadius * Math.sin(phi) * Math.cos(theta),
        CONFIG.sphereRadius * Math.cos(phi),
        CONFIG.sphereRadius * Math.sin(phi) * Math.sin(theta)
      ));
    }
    const line = new THREE.Line(
      new THREE.BufferGeometry().setFromPoints(pts),
      new THREE.LineBasicMaterial({ color: CONFIG.primaryColor, transparent: true, opacity: 0.12 })
    );
    scene.add(line);
    gridLines.push(line);
  }

  // Estrellas
  const starsPos = [];
  for (let i = 0; i < 300; i++)
    starsPos.push((Math.random()-0.5)*30, (Math.random()-0.5)*30, (Math.random()-0.5)*30);
  const starsGeo = new THREE.BufferGeometry();
  starsGeo.setAttribute('position', new THREE.Float32BufferAttribute(starsPos, 3));
  scene.add(new THREE.Points(starsGeo, new THREE.PointsMaterial({
    color: 0xffffff, size: 0.03, transparent: true, opacity: 0.35
  })));

  // Mouse
  let mouseX = 0, mouseY = 0, targetX = 0, targetY = 0;
  document.addEventListener('mousemove', e => {
    mouseX = (e.clientX / window.innerWidth  - 0.5) * 2;
    mouseY = (e.clientY / window.innerHeight - 0.5) * 2;
  });

  // Loop
  let clock = 0;
  function animate() {
    requestAnimationFrame(animate);
    clock += 0.016;
    targetX += (mouseX - targetX) * 0.04;
    targetY += (mouseY - targetY) * 0.04;

    sphereParticles.rotation.y += CONFIG.orbitSpeed + targetX * 0.005;
    sphereParticles.rotation.x  = targetY * 0.25;
    sphereMat.uniforms.uTime.value = clock;

    wire.rotation.y += 0.008;
    wire.rotation.x += 0.004;
    rings.forEach(r => { r.rotation.z += r.userData.speed; });

    const op = orbitGeo.attributes.position.array;
    let idx = 0;
    orbitData.forEach(od => {
      od.angle += ringConfigs[od.ring].speed * 1.5;
      op[idx    ] = Math.cos(od.angle) * od.radius;
      op[idx + 1] = Math.sin(od.angle) * od.radius * Math.sin(ringConfigs[od.ring].tilt[0] || 0.01);
      op[idx + 2] = Math.sin(od.angle) * od.radius;
      idx += 3;
    });
    orbitGeo.attributes.position.needsUpdate = true;

    gridLines.forEach((l, i) => {
      l.material.opacity = 0.06 + Math.sin(clock * 0.8 + i * 0.8) * 0.06;
    });

    camera.position.x += (targetX * 0.4 - camera.position.x) * 0.05;
    camera.position.y += (-targetY * 0.3 - camera.position.y) * 0.05;
    camera.lookAt(scene.position);
    renderer.render(scene, camera);
  }
  animate();

  window.addEventListener('resize', () => {
    const W = container.clientWidth, H = container.clientHeight;
    camera.aspect = W / H;
    camera.updateProjectionMatrix();
    renderer.setSize(W, H);
  });
})();
