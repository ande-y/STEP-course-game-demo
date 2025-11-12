extends enemy

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	speed = 180
	health = 50
	damage = 16
	pushForce = 300
	coins = randi_range(0, 2)
	$"attack cooldown".wait_time = 1.5
