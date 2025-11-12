extends CharacterBody2D
class_name turret

signal shoot
signal dropLoot

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var active: bool = false
var canShoot: bool = true

var health: int
var damage: int
var coins: int

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	if active and canShoot:
		canShoot = false
		$"shot cooldown".wait_time = randf_range(2, 4)
		$"shot cooldown".start()

func takeDamage(dmg: int):
	health -= dmg
	if health <= 0:
		dropLoot.emit(global_position, coins)
		$AnimationPlayer.play("death")

func _on_aggression_zone_body_entered(body: Node2D) -> void:
	active = true
func _on_aggression_zone_body_exited(body: Node2D) -> void:
	active = false

func _on_shot_cooldown_timeout() -> void:
	shoot.emit(Vector2.LEFT, $"left gun".global_position, damage)
	shoot.emit(Vector2.RIGHT, $"right gun".global_position, damage)
	canShoot = true
