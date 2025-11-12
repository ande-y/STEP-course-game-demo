extends enemy

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	health = 200
	speed = 300
	damage = 50
	coins = 30
