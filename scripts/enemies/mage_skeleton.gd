extends enemy

signal shoot

func _ready() -> void:
	health = 30
	speed = 220
	damage = 16
	coins = randi_range(1, 3)
	$"attack cooldown".wait_time = 2

func attack():
	if health <= 0:
		return
		
	$"attack cooldown".wait_time = randf_range(2.5, 4)
	direction = Globals.playerPosition - $"o/wand tip".global_position
	
	$o.scale.x = 1
	if direction.x < 0:
		$o.scale.x = -1
		
	attacking = true
	$o/weapon.play("attack")
	$AnimationPlayer.play("attack")
	shoot.emit(direction.normalized(), $"o/wand tip".global_position, damage)
	
	await $AnimationPlayer.animation_finished
	
	attacking = false
	$o/weapon.play("default")
	
	
