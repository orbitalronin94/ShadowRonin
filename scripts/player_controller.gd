extends CharacterBody3D
class_name RoninController

signal attack_requested(origin: Vector3, forward: Vector3)
signal health_changed(current: int, maximum: int)
signal defeated

@export var move_speed := 6.0
@export var max_health := 100
var health := 100
var invulnerability_left := 0.0
var attack_cooldown := 0.0
var dodge_left := 0.0
var touch_axis := Vector2.ZERO
var last_direction := Vector3.FORWARD

func _ready() -> void:
	health = max_health
	health_changed.emit(health, max_health)

func _physics_process(delta: float) -> void:
	invulnerability_left = maxf(0.0, invulnerability_left - delta)
	attack_cooldown = maxf(0.0, attack_cooldown - delta)
	dodge_left = maxf(0.0, dodge_left - delta)
	var axis := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	if axis.length() < 0.05:
		axis = touch_axis
	var cam := get_viewport().get_camera_3d()
	var direction := Vector3(axis.x, 0.0, axis.y)
	if cam:
		var forward := -cam.global_basis.z
		forward.y = 0.0
		var right := cam.global_basis.x
		right.y = 0.0
		direction = (right.normalized() * axis.x - forward.normalized() * axis.y).normalized()
	if direction.length() > 0.1:
		last_direction = direction
		look_at(global_position + direction, Vector3.UP)
	if dodge_left > 0.0:
		velocity.x = last_direction.x * 12.0
		velocity.z = last_direction.z * 12.0
	else:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	velocity.y = -0.5 if is_on_floor() else velocity.y - 22.0 * delta
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		perform_attack()
	if Input.is_action_just_pressed("dodge"):
		perform_dodge()

func set_touch_axis(value: Vector2) -> void:
	touch_axis = value

func perform_attack() -> void:
	if attack_cooldown > 0.0 or health <= 0:
		return
	attack_cooldown = 0.48
	attack_requested.emit(global_position + Vector3.UP, -global_basis.z)

func perform_dodge() -> void:
	if dodge_left > 0.0 or health <= 0:
		return
	dodge_left = 0.24
	invulnerability_left = 0.36

func take_damage(amount: int, source: Vector3) -> void:
	if invulnerability_left > 0.0 or health <= 0:
		return
	health = maxi(0, health - amount)
	invulnerability_left = 0.55
	var push := global_position - source
	push.y = 0.0
	if push.length() > 0.01:
		velocity += push.normalized() * 4.0
	health_changed.emit(health, max_health)
	if health == 0:
		defeated.emit()
