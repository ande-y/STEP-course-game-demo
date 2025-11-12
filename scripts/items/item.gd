extends CharacterBody2D
class_name item

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var value: int

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	if velocity.x != 0:
		velocity.x = (int)(velocity.x * .99)
	
func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

func _on_lifespan_timeout() -> void:
	$AnimationPlayer.play("vanish")
	
func _on_collection_area_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.
