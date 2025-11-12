extends Area2D

var speed: int = 500
var damage: int = 20
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	position += speed * direction * delta

func _on_body_entered(body: Node2D) -> void:
	if "takeDamage" in body:
		body.takeDamage(20)
	queue_free()
