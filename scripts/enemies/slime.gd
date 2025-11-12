extends enemy

func _ready() -> void:
	speed = 120
	health = 30
	damage = 8
	pushForce = 300
	coins = randi_range(0, 1)
	$"attack cooldown".wait_time = .2
		
