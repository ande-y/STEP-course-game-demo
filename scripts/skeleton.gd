extends CharacterBody2D


# import a node as a variable so that we dont have to write the node tree path over & over agian
@onready var sprite: AnimatedSprite2D = $o/sprite
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed: int = 250

func _process(delta: float) -> void:
	# get what direction the player is relative to the skeleton 
	var direction = Globals.playerPosition - position
	
	# move the skeleton based on where the player is
	if direction.x > 0:
		velocity.x = speed
	elif direction.x < 0:
		velocity.x = -speed
	
	if !is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
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
