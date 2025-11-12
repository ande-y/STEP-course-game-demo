extends level

const DUNGEON_LEVEL = preload("res://scenes/levels/dungeon_level.tscn")

func _on_exit_body_entered(_body: Node2D) -> void:
	LevelTransition.nextLevel(DUNGEON_LEVEL)
