THREE = require 'three'

container = undefined
camera = undefined
scene = undefined
projector = undefined
raycaster = undefined
renderer = undefined
parentTransform = undefined
mouse = new THREE.Vector2()
radius = 100
theta = 0
currentIntersected = undefined
config=
  direction:
    scaleor:1
    extra: -0.5
  parentTransform:
    position:
      scaleor:40
      extra: -20
    rotation:
      scaleor:2 * Math.PI
      extra: 0
    scale:
      scaleor:1
      extra: 0.5
  object:
    position:
      scaleor:0
      extra: 0
    rotation:
      scaleor:2 * Math.PI
      extra: 0
    scale:
      scaleor:1
      extra: 0.5

rand= (obj)->
  Math.random()*obj.scaleor + obj.extra
init = ->
  container = document.getElementById("main-background")
  camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 1, 10000)
  scene = new THREE.Scene()
  PI2 = Math.PI * 2
  geometry = new THREE.Geometry()
  point = new THREE.Vector3()
  direction = new THREE.Vector3()
  scaleor = 60
  for i in [0..100]
    direction.x += rand(config.direction)
    direction.y += rand(config.direction)
    direction.z += rand(config.direction)
    direction.normalize().multiplyScalar scaleor
    scaleor = 5
    point.add direction
    geometry.vertices.push point.clone()

  parentTransform = new THREE.Object3D()
  parentTransform.position.x = rand(config.parentTransform.position)
  parentTransform.position.y = rand(config.parentTransform.position)
  parentTransform.position.z = rand(config.parentTransform.position)
  parentTransform.rotation.x = rand(config.parentTransform.rotation)
  parentTransform.rotation.y = rand(config.parentTransform.rotation)
  parentTransform.rotation.z = rand(config.parentTransform.rotation)
  parentTransform.scale.x = rand(config.parentTransform.scale)
  parentTransform.scale.y = rand(config.parentTransform.scale)
  parentTransform.scale.z = rand(config.parentTransform.scale)

  for i in [0..50]
    type = (if Math.random() > 0.5 then THREE.LineStrip else THREE.LinePieces)
    object = new THREE.Line(geometry, new THREE.LineBasicMaterial(color: Math.random() * 0xffffff), type)
    object.position.x = rand(config.object.position)
    object.position.y = rand(config.object.position)
    object.position.z = rand(config.object.position)
    object.rotation.x = rand(config.object.rotation)
    object.rotation.y = rand(config.object.rotation)
    object.rotation.z = rand(config.object.rotation)
    object.scale.x = rand(config.object.scale)
    object.scale.y = rand(config.object.scale)
    object.scale.z = rand(config.object.scale)

    parentTransform.add object
  scene.add parentTransform
  projector = new THREE.Projector()
  raycaster = new THREE.Raycaster()
  raycaster.linePrecision = 3
  renderer = new THREE.WebGLRenderer(antialias: true)
  renderer.setClearColor 0xffffff
  renderer.setSize window.innerWidth, window.innerHeight
  container.appendChild renderer.domElement
  document.addEventListener "mousemove", onDocumentMouseMove, false
  window.addEventListener "resize", onWindowResize, false
  return
onWindowResize = ->
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()
  renderer.setSize window.innerWidth, window.innerHeight
  return
onDocumentMouseMove = (event) ->
  event.preventDefault()
  mouse.x = (event.clientX / window.innerWidth) * 2 - 1
  mouse.y = -(event.clientY / window.innerHeight) * 2 + 1
  return
animate = ->
  requestAnimationFrame animate
  render()
  return
render = ->
  theta += 0.05
  camera.position.x = radius * Math.sin(THREE.Math.degToRad(theta))
  camera.position.y = radius * Math.sin(THREE.Math.degToRad(theta))
  camera.position.z = radius * Math.cos(THREE.Math.degToRad(theta))
  camera.lookAt scene.position
  
  # find intersection
  vector = new THREE.Vector3(mouse.x, mouse.y, 1)
  projector.unprojectVector vector, camera
  raycaster.set camera.position, vector.sub(camera.position).normalize()
  intersects = raycaster.intersectObjects(parentTransform.children, true)
  if intersects.length > 0
    currentIntersected.material.linewidth = 1  if currentIntersected isnt `undefined`
    currentIntersected = intersects[0].object
    currentIntersected.material.linewidth = 5
  else
    currentIntersected.material.linewidth = 1  if currentIntersected isnt `undefined`
    currentIntersected = `undefined`
  renderer.render scene, camera
  return
module.exports =
  init: init
  animate: animate