extends enemy

signal slash

var canSlash: bool = true

func _ready() -> void:
	$"o/damage zone/CollisionShape2D".disabled = true
	health = 200
	speed = 300
	damage = 38
	pushForce = 500
	coins = randi_range(15, 20)
	$"attack cooldown".wait_time = 2

func summonSlash():
	direction = Globals.playerPosition - position
	slash.emit(direction.normalized(), $"o/sword tip".global_position, (int)(damage * .5))
	
func _on_slash_cooldown_timeout() -> void:
	if active:
		attack()
