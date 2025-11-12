extends obstacle

func _ready() -> void:
	health = 60
	coins = randi_range(3, 6)
	redPotion = .5
	bluePotion = .6
