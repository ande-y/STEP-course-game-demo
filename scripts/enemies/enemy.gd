extends CharacterBody2D
class_name enemy

# import a node as a variable so that we dont have to write the node tree path over & over agian
@onready var sprite: AnimatedSprite2D = $o/sprite
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var active: bool = false

var speed: int
var health: int
var damage: int

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
	velocity.x = speed * direction.x
		
	move_and_slide()
	
func movingAnimation():
	# the same as the player, the animations of the skeleton
	if velocity.y > 0:
		sprite.play("falling")
	elif velocity.y < 0:
		sprite.play("jumping")
	elif health > 0:
		if active and velocity.x != 0:
			sprite.play("moving")
		else:
			sprite.play("default")

	
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

func _on_aggression_zone_body_entered(_body: Node2D) -> void:
	active = true
func _on_aggression_zone_body_exited(_body: Node2D) -> void:
	active = false
