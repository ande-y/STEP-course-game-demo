extends item
class_name coin

var coinValue: int

func _on_collection_area_body_entered(_body: Node2D) -> void:
	print("got a coin")
	$AudioStreamPlayer2D.play()
	Globals.coins += value
	$sprite.visible = false
