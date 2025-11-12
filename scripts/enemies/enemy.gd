extends CharacterBody2D
class_name enemy

# import a node as a variable so that we dont have to write the node tree path over & over agian
@onready var sprite: AnimatedSprite2D = $o/sprite
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed: int
var health: int
var damage: int

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if health > 0:
		movingAnimation()
		movement()
	else:
		velocity.x = 0
	
	move_and_slide()
	
func movement():
	# get what direction the player is relative to the skeleton 
	var direction = Globals.playerPosition - position
	
	# move the skeleton based on where the player is
	if direction.x > 0:
		velocity.x = speed
	elif direction.x < 0:
		velocity.x = -speed
	
func movingAnimation():
	# the same as the player, the animations of the skeleton
	if velocity.y > 0:
		sprite.play("falling")
	elif velocity.y < 0:
		sprite.play("jumping")
	elif velocity.x == 0:
		sprite.play("default")
	else:
		sprite.play("moving")
	
	if velocity.x > 0:
		$o.scale.x = 1
	elif velocity.x < 0:
		$o.scale.x = -1

func takeDamage(dmg: int):
	health -= dmg
	if health <= 0:
		set_collision_layer_value(3, false)
		set_collision_mask_value(1, false)
		$"o/damage zone".monitoring = false
		$AnimationPlayer.play("death")

func _on_damage_zone_body_entered(body: Node2D) -> void:
	if "takeDamage" in body:
		body.takeDamage(damage)
