extends Node3D

var player: RoninController
var boss: KuroBoss
var camera_rig: Node3D
var camera: Camera3D
var boss_bar: ProgressBar
var player_bar: ProgressBar
var status_label: Label
var canvas_layer: CanvasLayer
var telegraph_ring: MeshInstance3D
var camera_shake := 0.0
var ended := false

func _ready() -> void:
	_build_world()
	_build_arena()
	_build_fighters()
	_build_camera()
	_build_hud()

func _process(delta: float) -> void:
	if is_instance_valid(player) and is_instance_valid(boss) and not ended:
		var desired := player.global_position + Vector3(0.0, 4.8, 9.0)
		camera_rig.global_position = camera_rig.global_position.lerp(desired, 1.0 - exp(-4.5 * delta))
		camera.look_at(player.global_position + Vector3.UP * 1.1, Vector3.UP)
	if camera_shake > 0.0:
		camera_shake = maxf(0.0, camera_shake - delta * 3.0)
		camera.position.x = sin(Time.get_ticks_msec() * 0.05) * camera_shake * 0.18
	else:
		camera.position.x = 0.0

func _build_world() -> void:
	var world := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.025, 0.012, 0.027)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.35, 0.25, 0.32)
	env.ambient_light_energy = 0.7
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.glow_enabled = true
	env.glow_intensity = 0.45
	env.fog_enabled = true
	env.fog_light_color = Color(0.2, 0.065, 0.09)
	env.fog_density = 0.016
	world.environment = env
	add_child(world)

	var moon := DirectionalLight3D.new()
	moon.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	moon.light_color = Color(0.58, 0.66, 0.86)
	moon.light_energy = 1.2
	moon.shadow_enabled = true
	add_child(moon)

	for pos in [Vector3(-11.0, 2.4, -7.0), Vector3(11.0, 2.4, -7.0), Vector3(-11.0, 2.4, 5.0), Vector3(11.0, 2.4, 5.0)]:
		var flame := OmniLight3D.new()
		flame.position = pos
		flame.light_color = Color(1.0, 0.16, 0.045)
		flame.light_energy = 2.2
		flame.omni_range = 7.0
		add_child(flame)

func _build_arena() -> void:
	_add_box("ArenaFloor", Vector3(0, -0.5, 0), Vector3(30, 1, 30), Color(0.105, 0.085, 0.105), true)
	_add_box("BackWall", Vector3(0, 3, -14.5), Vector3(30, 6, 0.7), Color(0.055, 0.035, 0.055), true)
	_add_box("LeftWall", Vector3(-14.5, 2.5, 0), Vector3(0.7, 5, 29), Color(0.055, 0.035, 0.055), true)
	_add_box("RightWall", Vector3(14.5, 2.5, 0), Vector3(0.7, 5, 29), Color(0.055, 0.035, 0.055), true)
	# Gate silhouette and raised duelling dais.
	_add_box("ToriiLeft", Vector3(-4.2, 3, -10.8), Vector3(0.9, 6, 0.9), Color(0.19, 0.075, 0.07), false)
	_add_box("ToriiRight", Vector3(4.2, 3, -10.8), Vector3(0.9, 6, 0.9), Color(0.19, 0.075, 0.07), false)
	_add_box("ToriiLintel", Vector3(0, 6, -10.8), Vector3(10, 0.8, 1.4), Color(0.31, 0.09, 0.075), false)
	_add_box("Dais", Vector3(0, 0.08, -5.5), Vector3(10, 0.16, 5), Color(0.16, 0.075, 0.09), false)
	for i in range(9):
		_add_box("StoneSeam_%02d" % i, Vector3(-12.0 + i * 3.0, 0.012, 0), Vector3(0.035, 0.02, 26), Color(0.25, 0.105, 0.12), false)
	for side in [-1.0, 1.0]:
		for z in [-7.0, 0.0, 7.0]:
			_add_box("BrazierStand", Vector3(side * 11.5, 1.0, z), Vector3(0.65, 2.0, 0.65), Color(0.13, 0.09, 0.075), false)

	telegraph_ring = MeshInstance3D.new()
	var torus := TorusMesh.new()
	torus.inner_radius = 2.9
	torus.outer_radius = 3.08
	telegraph_ring.mesh = torus
	telegraph_ring.rotation_degrees.x = 90
	var ring_mat := StandardMaterial3D.new()
	ring_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	ring_mat.albedo_color = Color(1.0, 0.1, 0.025, 0.9)
	ring_mat.emission_enabled = true
	ring_mat.emission = Color(1.0, 0.035, 0.005)
	ring_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	telegraph_ring.material_override = ring_mat
	telegraph_ring.visible = false
	add_child(telegraph_ring)

func _build_fighters() -> void:
	player = RoninController.new()
	player.name = "Ronin"
	player.position = Vector3(0, 0.12, 5)
	add_child(player)
	var pc := CapsuleShape3D.new()
	pc.radius = 0.42
	pc.height = 1.8
	_add_collision(player, pc, 0.9)
	_add_capsule(player, Vector3(0, 0.95, 0), 0.42, 1.35, Color(0.045, 0.04, 0.06))
	_add_box_child(player, "CrimsonMantle", Vector3(0, 1.35, -0.05), Vector3(0.95, 0.34, 0.55), Color(0.22, 0.035, 0.045))
	_add_box_child(player, "Katana", Vector3(0.55, 1.0, -0.42), Vector3(0.075, 0.075, 1.2), Color(0.65, 0.76, 0.86))

	boss = KuroBoss.new()
	boss.name = "Kuro"
	boss.position = Vector3(0, 0.12, -5)
	boss.set("player", player)
	add_child(boss)
	var bc := CapsuleShape3D.new()
	bc.radius = 0.95
	bc.height = 3.4
	_add_collision(boss, bc, 1.7)
	_add_capsule(boss, Vector3(0, 1.55, 0), 0.95, 2.6, Color(0.09, 0.022, 0.03))
	_add_sphere(boss, "DemonSkull", Vector3(0, 2.95, -0.2), 0.8, Color(0.14, 0.025, 0.035))
	_add_horn(boss, "HornLeft", Vector3(-0.58, 3.55, -0.2))
	_add_horn(boss, "HornRight", Vector3(0.58, 3.55, -0.2))
	_add_sphere(boss, "EyeLeft", Vector3(-0.3, 3.0, -0.9), 0.11, Color(1, 0.025, 0.005), true)
	_add_sphere(boss, "EyeRight", Vector3(0.3, 3.0, -0.9), 0.11, Color(1, 0.025, 0.005), true)

	player.attack_requested.connect(_on_player_attack)
	player.health_changed.connect(_on_player_health)
	player.defeated.connect(_on_player_defeated)
	boss.health_changed.connect(_on_boss_health)
	boss.telegraph_started.connect(_on_telegraph)
	boss.attack_resolved.connect(_on_boss_attack)
	boss.defeated.connect(_on_boss_defeated)

func _build_camera() -> void:
	camera_rig = Node3D.new()
	camera_rig.position = Vector3(0, 4.8, 14)
	add_child(camera_rig)
	camera = Camera3D.new()
	camera.position = Vector3(0, 0.2, 0)
	camera.fov = 54
	camera.current = true
	camera_rig.add_child(camera)
	camera.look_at(Vector3(0, 1, -1), Vector3.UP)

func _build_hud() -> void:
	canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)
	var root := Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas_layer.add_child(root)
	var title := Label.new()
	title.text = "SHADOWRONIN   /   THE TEN SEALS"
	title.position = Vector2(32, 22)
	title.add_theme_font_size_override("font_size", 22)
	title.add_theme_color_override("font_color", Color(0.94, 0.79, 0.68))
	root.add_child(title)
	var name := Label.new()
	name.text = "I   KURO, EL PERRO DEL UMBRAL"
	name.position = Vector2(32, 62)
	name.add_theme_font_size_override("font_size", 18)
	name.add_theme_color_override("font_color", Color(1.0, 0.3, 0.18))
	root.add_child(name)
	boss_bar = _bar(root, Vector2(32, 92), Vector2(430, 18), Color(0.78, 0.07, 0.045))
	player_bar = _bar(root, Vector2(32, 124), Vector2(230, 13), Color(0.75, 0.59, 0.43))
	status_label = Label.new()
	status_label.position = Vector2(32, 148)
	status_label.text = "WASD mover   ·   J atacar   ·   ESPACIO esquivar"
	status_label.add_theme_font_size_override("font_size", 15)
	status_label.add_theme_color_override("font_color", Color(0.85, 0.78, 0.76))
	root.add_child(status_label)
	_touch_button(root, "GOLPE", Vector2(-164, -130), Vector2(128, 56), func(): player.perform_attack())
	_touch_button(root, "ESQUIVA", Vector2(-164, -66), Vector2(128, 56), func(): player.perform_dodge())
	_touch_button(root, "◀", Vector2(30, -112), Vector2(52, 52), func(): player.set_touch_axis(Vector2(-1, 0)), func(): player.set_touch_axis(Vector2.ZERO))
	_touch_button(root, "▶", Vector2(144, -112), Vector2(52, 52), func(): player.set_touch_axis(Vector2(1, 0)), func(): player.set_touch_axis(Vector2.ZERO))
	_touch_button(root, "▲", Vector2(87, -168), Vector2(52, 52), func(): player.set_touch_axis(Vector2(0, -1)), func(): player.set_touch_axis(Vector2.ZERO))
	_touch_button(root, "▼", Vector2(87, -56), Vector2(52, 52), func(): player.set_touch_axis(Vector2(0, 1)), func(): player.set_touch_axis(Vector2.ZERO))

func _bar(parent: Control, at: Vector2, dimensions: Vector2, fill: Color) -> ProgressBar:
	var bar := ProgressBar.new()
	bar.position = at
	bar.size = dimensions
	bar.max_value = 100
	bar.value = 100
	bar.show_percentage = false
	var bg := StyleBoxFlat.new()
	bg.bg_color = Color(0.025, 0.018, 0.025)
	bar.add_theme_stylebox_override("background", bg)
	var fg := StyleBoxFlat.new()
	fg.bg_color = fill
	bar.add_theme_stylebox_override("fill", fg)
	parent.add_child(bar)
	return bar

func _touch_button(parent: Control, caption: String, offset: Vector2, dimensions: Vector2, down: Callable, up: Callable = Callable()) -> void:
	var button := Button.new()
	button.text = caption
	button.size = dimensions
	button.anchor_left = 1.0 if offset.x < 0 else 0.0
	button.anchor_right = button.anchor_left
	button.anchor_top = 1.0
	button.anchor_bottom = 1.0
	button.position = offset
	button.add_theme_font_size_override("font_size", 16)
	button.modulate = Color(1, 1, 1, 0.82)
	button.pressed.connect(down)
	if up.is_valid():
		button.button_up.connect(up)
	parent.add_child(button)

func _on_player_attack(origin: Vector3, forward: Vector3) -> void:
	if ended:
		return
	var to_boss := boss.global_position + Vector3.UP - origin
	to_boss.y = 0
	if to_boss.length() <= 2.9 and forward.dot(to_boss.normalized()) > 0.12:
		boss.take_damage(38, player.global_position)
		camera_shake = 0.8
		_hit_flash(boss.global_position + Vector3.UP * 1.8)
		status_label.text = "IMPACTO   ·   EL DEMONIO CEDE"
	else:
		status_label.text = "FILO AL AIRE   ·   ACÉRCATE Y ORIENTA EL GOLPE"

func _on_player_health(current: int, maximum: int) -> void:
	player_bar.max_value = maximum
	player_bar.value = current

func _on_boss_health(current: int, maximum: int) -> void:
	boss_bar.max_value = maximum
	boss_bar.value = current

func _on_telegraph(center: Vector3, radius: float) -> void:
	telegraph_ring.global_position = Vector3(center.x, 0.15, center.z)
	telegraph_ring.scale = Vector3.ONE * (radius / 3.0)
	telegraph_ring.visible = true
	status_label.text = "¡KURO PREPARA UNA EMBESTIDA!   ·   ESQUIVA"
	var tween := create_tween()
	tween.tween_property(telegraph_ring, "scale", Vector3.ONE * 1.15, 0.82)
	tween.tween_callback(func(): telegraph_ring.visible = false)

func _on_boss_attack(hit: bool) -> void:
	if hit:
		camera_shake = 1.0
		status_label.text = "GOLPE RECIBIDO   ·   BUSCA SU RECUPERACIÓN"
	else:
		status_label.text = "EMBESTIDA ESQUIVADA   ·   ¡CASTÍGALO!"

func _on_player_defeated() -> void:
	_finish("DERROTA", "El umbral todavía no se ha abierto.")

func _on_boss_defeated() -> void:
	_finish("PRIMER SELLO ROTO", "Nueve demonios siguen aguardando.")

func _finish(heading: String, subtitle: String) -> void:
	ended = true
	telegraph_ring.visible = false
	var shade := ColorRect.new()
	shade.color = Color(0.025, 0.012, 0.025, 0.9)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas_layer.add_child(shade)
	var title := Label.new()
	title.text = heading
	title.position = Vector2(0, -42)
	title.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	title.add_theme_font_size_override("font_size", 40)
	title.add_theme_color_override("font_color", Color(0.95, 0.34, 0.2))
	shade.add_child(title)
	var detail := Label.new()
	detail.text = subtitle + "\nPulsa R para volver a combatir."
	detail.position = Vector2(0, 22)
	detail.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	detail.add_theme_font_size_override("font_size", 19)
	shade.add_child(detail)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_R and ended:
		get_tree().reload_current_scene()

func _hit_flash(at: Vector3) -> void:
	var flash := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 0.42
	sphere.height = 0.84
	flash.mesh = sphere
	var mat := StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(1.0, 0.35, 0.08)
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.08, 0.01)
	flash.material_override = mat
	flash.global_position = at
	add_child(flash)
	var tween := create_tween()
	tween.tween_property(flash, "scale", Vector3.ONE * 2.2, 0.16)
	tween.tween_callback(flash.queue_free)

func _add_box(name: String, at: Vector3, dimensions: Vector3, color: Color, collision: bool) -> void:
	var visual := MeshInstance3D.new()
	visual.name = name
	var mesh := BoxMesh.new()
	mesh.size = dimensions
	visual.mesh = mesh
	visual.position = at
	visual.material_override = _mat(color)
	add_child(visual)
	if collision:
		var body := StaticBody3D.new()
		body.position = at
		var shape := CollisionShape3D.new()
		var box := BoxShape3D.new()
		box.size = dimensions
		shape.shape = box
		body.add_child(shape)
		add_child(body)

func _add_collision(parent: Node3D, shape_resource: Shape3D, y: float) -> void:
	var collision := CollisionShape3D.new()
	collision.shape = shape_resource
	collision.position.y = y
	parent.add_child(collision)

func _add_capsule(parent: Node3D, at: Vector3, radius: float, height: float, color: Color) -> void:
	var visual := MeshInstance3D.new()
	var mesh := CapsuleMesh.new()
	mesh.radius = radius
	mesh.height = height
	visual.mesh = mesh
	visual.position = at
	visual.material_override = _mat(color)
	parent.add_child(visual)

func _add_box_child(parent: Node3D, name: String, at: Vector3, dimensions: Vector3, color: Color) -> void:
	var visual := MeshInstance3D.new()
	visual.name = name
	var mesh := BoxMesh.new()
	mesh.size = dimensions
	visual.mesh = mesh
	visual.position = at
	visual.material_override = _mat(color)
	parent.add_child(visual)

func _add_sphere(parent: Node3D, name: String, at: Vector3, radius: float, color: Color, emissive: bool = false) -> void:
	var visual := MeshInstance3D.new()
	visual.name = name
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0
	visual.mesh = mesh
	visual.position = at
	visual.material_override = _mat(color, emissive)
	parent.add_child(visual)

func _add_horn(parent: Node3D, name: String, at: Vector3) -> void:
	var visual := MeshInstance3D.new()
	visual.name = name
	var mesh := CylinderMesh.new()
	mesh.top_radius = 0.015
	mesh.bottom_radius = 0.32
	mesh.height = 1.35
	visual.mesh = mesh
	visual.position = at
	visual.rotation_degrees.x = -90
	visual.material_override = _mat(Color(0.23, 0.16, 0.14))
	parent.add_child(visual)

func _mat(color: Color, emissive: bool = false) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.8
	if emissive:
		material.emission_enabled = true
		material.emission = color
		material.emission_energy_multiplier = 2.5
	return material
