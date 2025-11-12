extends CanvasLayer

func _ready() -> void:
	$ColorRect.color = Color(0, 0, 0, 0)

func transition(target: PackedScene):
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("fade")
