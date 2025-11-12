extends level

const DUNGEON_LEVEL = preload("res://scenes/levels/dungeon_level.tscn")

func _on_exit_body_entered(body: Node2D) -> void:
	LevelTransition.transition(DUNGEON_LEVEL)
