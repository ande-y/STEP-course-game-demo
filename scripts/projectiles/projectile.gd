extends Area2D
class_name projectile

var direction: Vector2 = Vector2.ZERO
var isUsed: bool = false

var speed: int
var damage: int
var pushForce: int

func _process(delta: float) -> void:
	position += speed * direction * delta

func _on_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if isUsed:
		return
	var tileMap: TileMapLayer
	if body.get_class() == "TileMapLayer":
		tileMap = body
		var currentTile = tileMap.get_coords_for_body_rid(body_rid)
		var data = tileMap.get_cell_tile_data(currentTile)
		if data.get_custom_data("platform"):
			return
	if "takeDamage" in body:
		body.takeDamage(damage, direction, pushForce)
	isUsed = true
	removeProj()

func _on_timer_timeout() -> void:
	if !isUsed:
		removeProj()
		isUsed = true
	
func removeProj():
	speed = 0
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("poof")
