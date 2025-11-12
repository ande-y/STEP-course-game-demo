extends item
class_name potion

var heal: int = 0
var energy: int = 0

func _on_collection_area_body_entered(_body: Node2D) -> void:
	print("got a potion")
	$AudioStreamPlayer2D.play()
	Globals.health += heal
	Globals.energy += energy
	$sprite.visible = false
