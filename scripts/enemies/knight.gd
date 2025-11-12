extends enemy

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	health = 120
	speed = 200
	damage = 22
	pushForce = 300
	coins = randi_range(3, 6)
	$"attack cooldown".wait_time = 2.5
