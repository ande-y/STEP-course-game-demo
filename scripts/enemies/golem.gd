extends enemy

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	health = 200
	speed = 300
	damage = 32
	pushForce = 500
	coins = randi_range(10, 15)
	$"attack cooldown".wait_time = 2
