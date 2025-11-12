extends StaticBody2D
class_name obstacle

signal dropLoot

var health: int
var coins: int

func takeDamage(dmg: int, _dir: Vector2):
	health -= dmg
	if health <= 0:
		$sprite.play("break")
		$AnimationPlayer.play("fade")
