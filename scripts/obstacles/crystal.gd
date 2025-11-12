extends obstacle

signal slash

var damage: int = 15
var active: bool = false

func _ready() -> void:
	health = 100
	coins = randi_range(0, 10)
	redPotion = 1
	$"attack cooldown".wait_time = randf_range(4, 7)

func _on_aggression_zone_body_entered(_body: Node2D) -> void:
	active = true
	$"attack cooldown".start()
func _on_aggression_zone_body_exited(_body: Node2D) -> void:
	active = false
	$"attack cooldown".stop()
	
func _on_timer_timeout() -> void:
	if health <= 0:
		return
	$"attack cooldown".wait_time = randf_range(4, 7)
	for i in range(-1, 2):
		for j in range(-1, 2):
			if i == 0 and j == 0:
				continue
			slash.emit(Vector2(i, j).normalized().rotated(randf_range(-.1, .1)), global_position, damage)

	
