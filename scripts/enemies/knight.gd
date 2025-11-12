extends enemy

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	health = 120
	speed = 200
	damage = 35
	coins = 10
