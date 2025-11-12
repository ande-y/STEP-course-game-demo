extends CharacterBody2D

signal playerMagic

@onready var sprite: AnimatedSprite2D = $o/sprite
@onready var wand: AnimatedSprite2D = $o/wand

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
const speed: int = 400
const jump: int = -510
var direction: float

var canJump: bool = true
var knockback: int = 0
var invFrame: bool = false
var canShoot: bool = true

func _process(delta: float) -> void:
	movement(delta)
	if Globals.health <= 0: 
		return
	movingAnimation()
	attack()
	
func attack():
	var cost: int = 17
	if Input.is_action_just_pressed("LeftClick") and Globals.energy >= cost and canShoot:
		canShoot = false
		$"shot cooldown".start()
		var facing: Vector2 = Vector2.ZERO
		if Input.is_action_pressed("up"):
			facing = Vector2.UP
		elif Input.is_action_pressed("down"):
			facing = Vector2.DOWN
		elif $o.scale.x == -1:
			facing = Vector2.LEFT
		else:
			facing = Vector2.RIGHT
		playerMagic.emit(facing.rotated(randf_range(-.05, .05)), $"o/wand/tip of wand".global_position)
		playerMagic.emit(facing.rotated(-.25).rotated(randf_range(-.05, .05)), $"o/wand/tip of wand".global_position)
		playerMagic.emit(facing.rotated(.25).rotated(randf_range(-.05, .05)), $"o/wand/tip of wand".global_position)
		wand.stop()
		wand.play("flick")
		Globals.energy -= cost
	
func movement(delta: float):
	# send the player's position to the Global script so that enemies are able to know where the player is 
	Globals.playerPosition = position
	
	if knockback != 0:
		knockback = int(knockback - (knockback * delta * 2))
	if !is_on_floor():
		velocity.y += gravity * delta
	else: 
		canJump = true
		
	if Globals.health <= 0:
		velocity.x = knockback
		move_and_slide()
		return
	
	# code for moving character
	direction = Input.get_axis("left", "right")
	velocity.x = speed * direction + knockback
	
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
		if direction < 0:
			$o.scale.x = -1
		elif direction > 0:
			$o.scale.x = 1

func takeDamage(dmg: int, dir: Vector2, kb: int):
	if invFrame or Globals.health <= 0:
		return
	invFrame = true
	$"invincibility frames".start()
	Globals.health -= dmg
	knockback = (int)(kb * dir.x)
	print("ouch " + str(Globals.health))
	if Globals.health <= 0:
		$o/wand.visible = false
		sprite.play("death")
		LevelTransition.restartLevel()
	
func _on_invincibility_frames_timeout() -> void:
	invFrame = false
	
func _on_energy_regeneration_timeout() -> void:
	Globals.energy += 4

var temp1; var temp2; var temp3; var temp4
func _on_hazard_detector_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	var tileMap: TileMapLayer = body
	var currentTile = tileMap.get_coords_for_body_rid(body_rid)
	var data = tileMap.get_cell_tile_data(currentTile)
	var damage = data.get_custom_data("hazard")
	takeDamage(damage, Vector2(-scale.x, 0), 50)
	$"hazard timer".start()
	temp1 = body_rid
	temp2 = body
	temp3 = _body_shape_index
	temp4 = _local_shape_index
func _on_hazard_detector_body_exited(_body: Node2D) -> void:
	$"hazard timer".stop()
func _on_hazard_timer_timeout() -> void:
	_on_hazard_detector_body_shape_entered(temp1, temp2, temp3, temp4)
	$"hazard timer".start()

func _on_shot_cooldown_timeout() -> void:
	canShoot = true
