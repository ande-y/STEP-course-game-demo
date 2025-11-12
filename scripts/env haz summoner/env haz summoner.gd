extends StaticBody2D
class_name hazSummoner

signal dripProjectile

var projectileType: PackedScene

func _on_cooldown_timeout() -> void:
	$cooldown.wait_time = randf_range(3, 6)
	$AnimationPlayer.play("drip")
	
func drip():
	dripProjectile.emit($tip.global_position, projectileType)
