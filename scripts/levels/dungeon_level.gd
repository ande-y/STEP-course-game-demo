extends level

const VOLCANO_LEVEL = preload("res://scenes/levels/volcano_level.tscn")

func _on_exit_body_entered(_body: Node2D) -> void:
	LevelTransition.nextLevel(VOLCANO_LEVEL)
