extends CharacterBody2D
class_name enemy

signal dropCoin
signal dropPotion

# import a node as a variable so that we dont have to write the node tree path over & over agian
@onready var sprite: AnimatedSprite2D = $o/sprite
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var active: bool = false
var knockback: int = 0
var attacking: bool = false
var inRange: bool = false
var canAttack: bool = true
var direction: Vector2

var speed: int
var health: int
var damage: int
var pushForce: int
var coins: int = 0
var redPotion: float = 0
var bluePotion: float = 0

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# get what direction the player is relative to the skeleton 
	direction = Globals.playerPosition - position
	movingAnimation()
	movement(delta)
	
	if canAttack and inRange:
		canAttack = false
		$"attack cooldown".start()
		attack()
	
func movement(delta: float):
	# move the skeleton based on where the player is
	if health <= 0 or attacking or inRange or (direction.x > -5 and direction.x < 5):
		direction.x = 0
	elif active:
		direction.x /= abs(direction.x)
	else:
		direction.x = 0
	velocity.x = speed * direction.x + knockback
	
	if knockback != 0:
		knockback = int(knockback - (knockback * delta * 2))
		
	move_and_slide()

func movingAnimation():
	# the same as the player, the animations of the skeleton
	if health <= 0:
		return
	
	if attacking:
		sprite.play("attacking")
	elif velocity.y > 0:
		sprite.play("falling")
	elif velocity.y < 0:
		sprite.play("jumping")
	elif knockback != 0 and velocity.x * direction.x < 0:
		sprite.play("hurt")
	elif active and velocity.x != 0:
		sprite.play("moving")
	else:
		sprite.play("default")
	
	if knockback == 0:
		if direction.x > 0:
			$o.scale.x = 1
		elif direction.x < 0:
			$o.scale.x = -1

func takeDamage(dmg: int, dir: Vector2, kb: int):
	var prevHealth = health
	health -= dmg
	knockback = int(kb * dir.x)
	if health <= 0 and prevHealth > 0:
		set_collision_layer_value(3, false)
		set_collision_mask_value(1, false)
		$"o/damage zone".monitoring = false
		$o/weapon.visible = false
		dropCoin.emit(global_position, coins)
		dropPotion.emit(global_position, redPotion, bluePotion)
		$AnimationPlayer.play("death")

func _on_damage_zone_body_entered(body: Node2D) -> void:
	direction = Globals.playerPosition - position
	direction /= abs(direction)
	if "takeDamage" in body:
		body.takeDamage(damage, direction, pushForce)

func _on_aggression_zone_body_entered(_body: Node2D) -> void:
	active = true
func _on_aggression_zone_body_exited(_body: Node2D) -> void:
	active = false

func _on_attack_zone_body_entered(_body: Node2D) -> void:
	inRange = true
func _on_attack_zone_body_exited(_body: Node2D) -> void:
	inRange = false

func attack():
	if health <= 0:
		return
	attacking = true
	$"o/attack zone".set_deferred("monitoring", false)
	$o/weapon.play("attack")
	$AnimationPlayer.play("attack")
	
	await $AnimationPlayer.animation_finished
	
	attacking = false
	$"o/attack zone".set_deferred("monitoring", true)
	$o/weapon.play("default")
	
func _on_attack_cooldown_timeout() -> void:
	canAttack = true
