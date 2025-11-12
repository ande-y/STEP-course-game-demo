extends Node2D

var magicBullet: PackedScene = preload("res://scenes/projectile/purple_magic.tscn")

func _on_player_player_magic(dir: Vector2, pos: Vector2) -> void:
	var obj = magicBullet.instantiate() as Area2D
	obj.direction = dir
	obj.position = pos
	add_child(obj)
