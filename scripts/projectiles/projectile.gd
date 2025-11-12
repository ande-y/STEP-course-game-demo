extends Area2D
class_name projectile

var direction: Vector2 = Vector2.ZERO

var speed: int
var damage: int

func _process(delta: float) -> void:
	position += speed * direction * delta

func _on_body_entered(body: Node2D) -> void:
	if "takeDamage" in body:
		body.takeDamage(damage, direction)
	removeProj()

func _on_timer_timeout() -> void:
	removeProj()
	
func removeProj():
	speed = 0
	$AnimationPlayer.play("poof")
