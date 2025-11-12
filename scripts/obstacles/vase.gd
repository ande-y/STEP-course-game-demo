extends obstacle

func _ready() -> void:
	health = 20
	coins = randi_range(0, 3)
	redPotion = .9
	bluePotion = .3
