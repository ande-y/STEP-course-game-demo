extends CharacterBody2D
class_name turret

signal dropCoin
signal dropPotion

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var active: bool = false
var canShoot: bool = true

var health: int
var damage: int
var coins: int
var redPotion: float = 0
var bluePotion: float = 0

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	if active and canShoot:
		canShoot = false
		setShotTimer()
		$"shot cooldown".start()

func takeDamage(dmg: int, _dir: Vector2, _kb: int):
	var prevHealth = health
	health -= dmg
	if health <= 0 and prevHealth > 0:
		set_collision_layer_value(7, false)
		set_collision_mask_value(7, false)
		dropCoin.emit(global_position, coins)
		dropPotion.emit(global_position, redPotion, bluePotion)
		$"shot cooldown".stop()
		$AnimationPlayer.play("death")
	elif health > 0:
		$AnimationPlayer.play("hurt")

func _on_aggression_zone_body_entered(_body: Node2D) -> void:
	active = true
func _on_aggression_zone_body_exited(_body: Node2D) -> void:
	active = false

func _on_shot_cooldown_timeout() -> void:
	if health >0:
		fireGuns()

func setShotTimer():
	pass # function is coded in the child scenes

func fireGuns():
	pass # function is coded in the child scenes
