extends projectile

func _ready() -> void:
	speed = 100
	damage = 20
	pushForce = 200

func _process(delta: float) -> void:
	position += speed * direction * delta
	if speed < 800:
		speed = int(speed * 1.02)
