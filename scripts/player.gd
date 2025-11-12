extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $o/sprite
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
const speed: int = 400
const jump: int = -500

var canJump: bool = true

func _process(delta: float) -> void:
	# send the player's position to the Global script so that enemies are able to know where the player is 
	Globals.playerPosition = position
	
	# code for moving character
	var direction = Input.get_axis("left", "right")
	velocity.x = speed * direction
	
	if !is_on_floor():
		velocity.y += gravity * delta
		canJump = false
	else: 
		canJump = true
	
	# for if you are able to jump, attention on "canJump", this limits when and how you can jump
	if Input.is_action_just_pressed("space") and canJump:
		velocity.y = jump
		canJump = false
	
	move_and_slide()

	# coding for animating sprites
	if velocity.y > 0:
		sprite.play("falling")
	elif velocity.y < 0:
		sprite.play("jumping")
	elif velocity.x == 0:
		sprite.play("default")
	else:
		sprite.play("moving")
	
	# due to a bug in Godot, scale doesn't work properly on the root node
	# must parent everything we want to flip to node and flipping that node instead
	if velocity.x < 0:
		$o.scale.x = -1
	elif velocity.x > 0:
		$o.scale.x = 1
	
	
	
	
	
	
