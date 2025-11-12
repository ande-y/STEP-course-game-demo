extends obstacle

func _ready() -> void:
	health = 60
	coins = randi_range(6, 10)
	redPotion = .7
	bluePotion = .9
