extends CharacterBody2D
class_name enemy

signal dropLoot

# import a node as a variable so that we dont have to write the node tree path over & over agian
@onready var sprite: AnimatedSprite2D = $o/sprite
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var active: bool = false
var knockback: int = 0

var speed: int
var health: int
var damage: int
var coins: int

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	movingAnimation()
	movement()
	
func movement():
	# get what direction the player is relative to the skeleton 
	var direction = Globals.playerPosition - position
	
	# move the skeleton based on where the player is
	if health <= 0:
		direction.x = 0
	elif active:
		direction.x /= abs(direction.x)
	else:
		direction.x = 0
	velocity.x = speed * direction.x + knockback
	
	if knockback != 0:
		knockback = (int)(knockback * .98)
		
	move_and_slide()
	
func movingAnimation():
	# the same as the player, the animations of the skeleton
	if velocity.y > 0:
		sprite.play("falling")
	elif velocity.y < 0:
		sprite.play("jumping")
	elif health > 0:
		if knockback != 0:
			sprite.play("hurt")
		elif active and velocity.x != 0:
			sprite.play("moving")
		else:
			sprite.play("default")
	
	if knockback == 0:
		if velocity.x > 0:
			$o.scale.x = 1
		elif velocity.x < 0:
			$o.scale.x = -1

func takeDamage(dmg: int, dir: Vector2):
	health -= dmg
	knockback = (int)(300 * dir.x)
	if health <= 0:
		set_collision_layer_value(3, false)
		set_collision_mask_value(1, false)
		$"o/damage zone".monitoring = false
		dropLoot.emit(global_position, coins)
		$AnimationPlayer.play("death")

func _on_damage_zone_body_entered(body: Node2D) -> void:
	var direction = Globals.playerPosition - position
	direction /= abs(direction)
	if "takeDamage" in body:
		body.takeDamage(damage, direction)

func _on_aggression_zone_body_entered(_body: Node2D) -> void:
	active = true
func _on_aggression_zone_body_exited(_body: Node2D) -> void:
	active = false
