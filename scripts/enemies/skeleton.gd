extends enemy

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	speed = 150
	health = 50
	damage = 15
	coins = 3
