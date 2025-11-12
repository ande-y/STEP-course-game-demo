extends turret

signal shoot

func _ready() -> void:
	health = 140
	damage = 15
	coins = randi_range(5, 8)

func setShotTimer():
	$"shot cooldown".wait_time = randf_range(4, 6)

func fireGuns():
	for i in 6:
		shoot.emit(Vector2.LEFT.rotated(randf_range(-.4, .4)), $"left gun".global_position, damage)
		shoot.emit(Vector2.RIGHT.rotated(randf_range(-.4, .4)), $"right gun".global_position, damage)
	canShoot = true
