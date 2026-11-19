extends CharacterBody3D
class_name KuroBoss

signal health_changed(current: int, maximum: int)
signal telegraph_started(center: Vector3, radius: float)
signal attack_resolved(hit: bool)
signal defeated

enum State { APPROACH, WINDUP, STRIKE, RECOVERY, DEAD }
@export var max_health := 360
var health := 360
var player: RoninController
var state: State = State.APPROACH
var timer := 0.0
var cooldown := 1.0
var strike_center := Vector3.ZERO
var strike_radius := 3.35

func _ready() -> void:
	health = max_health
	health_changed.emit(health, max_health)

func _physics_process(delta: float) -> void:
	if state == State.DEAD or not is_instance_valid(player):
		return
	timer += delta
	cooldown = maxf(0.0, cooldown - delta)
	var offset := player.global_position - global_position
	offset.y = 0.0
	var distance := offset.length()
	match state:
		State.APPROACH:
			if distance > 2.8:
				var dir := offset.normalized()
				velocity.x = dir.x * 2.4
				velocity.z = dir.z * 2.4
				look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			else:
				velocity.x = move_toward(velocity.x, 0.0, 12.0 * delta)
				velocity.z = move_toward(velocity.z, 0.0, 12.0 * delta)
				if cooldown <= 0.0:
					state = State.WINDUP
					timer = 0.0
					strike_center = player.global_position
					telegraph_started.emit(strike_center, strike_radius)
		State.WINDUP:
			velocity.x = move_toward(velocity.x, 0.0, 18.0 * delta)
			velocity.z = move_toward(velocity.z, 0.0, 18.0 * delta)
			if timer >= 0.82:
				state = State.STRIKE
				timer = 0.0
				var d := player.global_position - strike_center
				d.y = 0.0
				var hit := d.length() <= strike_radius
				if hit:
					player.take_damage(18, global_position)
				attack_resolved.emit(hit)
		State.STRIKE:
			if timer >= 0.18:
				state = State.RECOVERY
				timer = 0.0
		State.RECOVERY:
			if timer >= 1.05:
				state = State.APPROACH
				timer = 0.0
				cooldown = 0.7
	velocity.y = -0.5 if is_on_floor() else velocity.y - 22.0 * delta
	move_and_slide()

func take_damage(amount: int, source: Vector3) -> void:
	if state == State.DEAD:
		return
	health = maxi(0, health - amount)
	health_changed.emit(health, max_health)
	var push := global_position - source
	push.y = 0.0
	if push.length() > 0.01:
		global_position += push.normalized() * 0.12
	if health == 0:
		state = State.DEAD
		defeated.emit()
	elif state == State.WINDUP:
		state = State.RECOVERY
		timer = 0.0
