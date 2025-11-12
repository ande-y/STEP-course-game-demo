extends obstacle

func _ready() -> void:
	health = 30
	coins = randi_range(0, 3)
	redPotion = .3
	bluePotion = .3
