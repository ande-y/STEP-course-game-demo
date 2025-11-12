extends Node2D

const purple: PackedScene = preload("res://scenes/projectile/purple_magic.tscn")
const red: PackedScene = preload("res://scenes/projectile/red_magic.tscn")

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("enemies can shoot"):
		node.connect("shoot", enemyShoot)

func _on_player_player_magic(dir: Vector2, pos: Vector2) -> void:
	var obj = purple.instantiate() as Area2D
	obj.direction = dir
	obj.position = pos
	add_child(obj)

func enemyShoot(dir: Vector2, pos: Vector2, dmg: int) -> void:
	var obj = red.instantiate() as Area2D
	obj.direction = dir
	obj.position = pos
	obj.damage = dmg
	add_child(obj)
