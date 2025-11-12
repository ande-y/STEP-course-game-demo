extends CharacterBody2D

signal playerMagic

@onready var sprite: AnimatedSprite2D = $o/sprite
@onready var wand: AnimatedSprite2D = $o/wand

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
const speed: int = 400
const jump: int = -500

var canJump: bool = true
var knockback: int = 0

func _process(delta: float) -> void:
	movement(delta)
	movingAnimation()
	attack()
	
func attack():
	var cost: int = 8
	if Input.is_action_just_pressed("LeftClick") and Globals.energy >= cost:
		var facing: Vector2 = Vector2.ZERO
		if Input.is_action_pressed("up"):
			facing = Vector2.UP
		elif Input.is_action_pressed("down"):
			facing = Vector2.DOWN
		elif $o.scale.x == -1:
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
	velocity.x = speed * direction + knockback
	
	if knockback != 0:
		knockback = (int)(knockback * 0.98)
	
	if !is_on_floor():
		velocity.y += gravity * delta
	else: 
		canJump = true
	
	# for if you are able to jump, attention on "canJump", this limits when and how you can jump
	if Input.is_action_just_pressed("space") and canJump:
		velocity.y = jump
		$AudioStreamPlayer2D.play()
		if !is_on_floor():
			canJump = false
	
	move_and_slide()

func movingAnimation():
	# coding for animating sprites
	if knockback != 0:
		sprite.play("hurt")
	elif velocity.y > 0:
		sprite.play("falling")
	elif velocity.y < 0:
		sprite.play("jumping")
	elif velocity.x == 0:
		sprite.play("default")
	else:
		sprite.play("moving")
	
	# due to a bug in Godot, scale doesn't work properly on the root node
	# must parent everything we want to flip to node and flipping that node instead
	if knockback == 0:
		if velocity.x < 0:
			$o.scale.x = -1
		elif velocity.x > 0:
			$o.scale.x = 1

func takeDamage(dmg: int, dir: Vector2):
	Globals.health -= dmg
	knockback = (int)(300 * dir.x)
	print("ouch " + str(Globals.health))

func _on_energy_regeneration_timeout() -> void:
	if Globals.energy < 100:
		Globals.energy += 2
	else:
		Globals.energy = 100

func _on_hazard_detector_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	var tileMap: TileMapLayer = body
	var currentTile = tileMap.get_coords_for_body_rid(body_rid)
	var data = tileMap.get_cell_tile_data(currentTile)
	var damage = data.get_custom_data("hazard")
	takeDamage(damage, Vector2.ZERO)
	
	
	
	
	
	
	
	
	
