extends turret

signal shoot

func _ready() -> void:
	health = 100
	damage = 12
	coins = randi_range(2, 5)

func setShotTimer():
	$"shot cooldown".wait_time = randf_range(2, 3)

func fireGuns():
	shoot.emit(Vector2.LEFT.rotated(randf_range(-.3, .3)), $"left gun".global_position, damage)
	shoot.emit(Vector2.RIGHT.rotated(randf_range(-.3, .3)), $"right gun".global_position, damage)
	canShoot = true
