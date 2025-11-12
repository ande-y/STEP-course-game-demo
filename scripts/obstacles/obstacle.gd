extends StaticBody2D
class_name obstacle

signal dropCoin
signal dropPotion

var health: int
var coins: int
var redPotion: float = 0
var bluePotion: float = 0

func takeDamage(dmg: int, _dir: Vector2, _kb: int):
	var prevHealth = health
	health -= dmg
	if health <= 0 and prevHealth > 0:
		set_collision_layer_value(6, false)
		dropCoin.emit(global_position, coins)
		dropPotion.emit(global_position, redPotion, bluePotion)
		$sprite.play("break")
		$AnimationPlayer.play("fade")
