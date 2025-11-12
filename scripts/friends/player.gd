extends CharacterBody2D

signal playerMagic

@onready var sprite: AnimatedSprite2D = $o/sprite
@onready var wand: AnimatedSprite2D = $o/wand

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
const speed: int = 400
const jump: int = -500

var canJump: bool = true

func _process(delta: float) -> void:
	movement(delta)
	attack()
	
func attack():
	var cost: int = 8
	if Input.is_action_just_pressed("LeftClick") and Globals.energy >= cost:
		var facing: Vector2 = Vector2.ZERO
		if $o.scale.x == -1:
			facing = Vector2.LEFT
		else:
			facing = Vector2.RIGHT
		playerMagic.emit(facing, $"o/wand/tip of wand".global_position)
		wand.play("flick")
		Globals.energy -= cost
	
func movement(delta: float):
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

func takeDamage(dmg: int):
	Globals.health -= dmg
	print("ouch " + str(Globals.health))

func _on_energy_regeneration_timeout() -> void:
	if Globals.energy < 100:
		Globals.energy += 2
	else:
		Globals.energy = 100
