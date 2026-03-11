/* hero3d.js - Nexfuturo Consulting */
window.addEventListener('load', function () {

  var el = document.getElementById('hero3d');
  if (!el) { return; }
  if (typeof THREE === 'undefined') { return; }

  var W = el.offsetWidth  || 500;
  var H = el.offsetHeight || 500;

  /* Renderer con fondo solido navy */
  var renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setSize(W, H);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.setClearColor(0x0a0f1e, 1);
  el.appendChild(renderer.domElement);

  var scene  = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera(60, W / H, 0.1, 100);
  camera.position.z = 6.5;

  /* ---- Esfera de puntos ---- */
  var N = 1800, R = 2.2;
  var pos = [], col = [];
  for (var i = 0; i < N; i++) {
    var phi   = Math.acos(1 - 2 * i / N);
    var theta = Math.PI * (1 + Math.sqrt(5)) * i;
    var r     = R + (Math.random() - 0.5) * 0.25;
    pos.push(r * Math.sin(phi) * Math.cos(theta),
             r * Math.sin(phi) * Math.sin(theta),
             r * Math.cos(phi));
    var t = Math.random();
    col.push(t * 0.1 + (1-t) * 0.102,
             t * 0.44 + (1-t) * 0.898,
             t * 1.0  + (1-t) * 1.0);
  }
  var geo = new THREE.BufferGeometry();
  geo.setAttribute('position', new THREE.Float32BufferAttribute(pos, 3));
  geo.setAttribute('color',    new THREE.Float32BufferAttribute(col, 3));

  var mat = new THREE.PointsMaterial({
    size: 0.045,
    vertexColors: true,
    transparent: true,
    opacity: 0.9,
    sizeAttenuation: true
  });

  var sphere = new THREE.Points(geo, mat);
  scene.add(sphere);

  /* ---- Nucleo wireframe ---- */
  var core = new THREE.Mesh(
    new THREE.SphereGeometry(0.55, 14, 14),
    new THREE.MeshBasicMaterial({ color: 0x00e5ff, wireframe: true, transparent: true, opacity: 0.3 })
  );
  scene.add(core);

  /* ---- Anillos ---- */
  var ringData = [
    { r: 2.85, tube: 0.013, rx: 0.4,  ry: 0,   rz: 0,   spd:  0.007, color: 0x00e5ff, op: 0.7 },
    { r: 3.25, tube: 0.009, rx: 0,    ry: 0.6,  rz: 0.3, spd: -0.004, color: 0x1a6fff, op: 0.5 },
    { r: 3.65, tube: 0.007, rx: 0.8,  ry: 0.2,  rz: 0,   spd:  0.003, color: 0x3d8bff, op: 0.35 }
  ];
  var rings = ringData.map(function(d) {
    var m = new THREE.Mesh(
      new THREE.TorusGeometry(d.r, d.tube, 8, 100),
      new THREE.MeshBasicMaterial({ color: d.color, transparent: true, opacity: d.op })
    );
    m.rotation.set(d.rx, d.ry, d.rz);
    m.userData.spd = d.spd;
    scene.add(m);
    return m;
  });

  /* ---- Estrellas fondo ---- */
  var sp = [];
  for (var i = 0; i < 400; i++)
    sp.push((Math.random()-0.5)*25, (Math.random()-0.5)*25, (Math.random()-0.5)*25);
  var sg = new THREE.BufferGeometry();
  sg.setAttribute('position', new THREE.Float32BufferAttribute(sp, 3));
  scene.add(new THREE.Points(sg, new THREE.PointsMaterial({
    color: 0xffffff, size: 0.035, transparent: true, opacity: 0.4
  })));

  /* ---- Mouse ---- */
  var mx = 0, my = 0, tx = 0, ty = 0;
  window.addEventListener('mousemove', function(e) {
    mx = (e.clientX / window.innerWidth  - 0.5) * 2;
    my = (e.clientY / window.innerHeight - 0.5) * 2;
  });

  /* ---- Loop ---- */
  var t = 0;
  (function loop() {
    requestAnimationFrame(loop);
    t += 0.016;
    tx += (mx - tx) * 0.04;
    ty += (my - ty) * 0.04;

    sphere.rotation.y += 0.002 + tx * 0.004;
    sphere.rotation.x  = ty * 0.2;

    core.rotation.y += 0.009;
    core.rotation.x += 0.005;

    rings.forEach(function(rng) { rng.rotation.z += rng.userData.spd; });

    camera.position.x += (tx * 0.3  - camera.position.x) * 0.05;
    camera.position.y += (-ty * 0.25 - camera.position.y) * 0.05;
    camera.lookAt(0, 0, 0);

    renderer.render(scene, camera);
  })();

  /* ---- Resize ---- */
  window.addEventListener('resize', function() {
    var nW = el.offsetWidth || 500;
    var nH = el.offsetHeight || 500;
    camera.aspect = nW / nH;
    camera.updateProjectionMatrix();
    renderer.setSize(nW, nH);
  });

});