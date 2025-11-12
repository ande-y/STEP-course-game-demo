extends CharacterBody2D
class_name item

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var value: int

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func _on_collection_area_body_entered(body: Node2D) -> void:
	Globals.coins += value
	queue_free()
