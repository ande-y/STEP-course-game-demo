extends turret

signal shoot

func _ready() -> void:
	health = 60
	damage = 10
	coins = randi_range(0, 3)

func setShotTimer():
	$"shot cooldown".wait_time = randf_range(3, 4)

func fireGuns():
	shoot.emit(Vector2.LEFT.rotated(randf_range(-.2, .2)), $"left gun".global_position, damage)
	shoot.emit(Vector2.RIGHT.rotated(randf_range(-.2, .2)), $"right gun".global_position, damage)
	canShoot = true
