extends Node2D

const BRONZE_COIN = preload("res://scenes/items/bronze_coin.tscn")
const SILVER_COIN = preload("res://scenes/items/silver_coin.tscn")
const GOLD_COIN = preload("res://scenes/items/gold_coin.tscn")

const purple: PackedScene = preload("res://scenes/projectile/purple_magic.tscn")
const red: PackedScene = preload("res://scenes/projectile/red_magic.tscn")

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("enemies can shoot"):
		node.connect("shoot", enemyShoot)
	for node in get_tree().get_nodes_in_group("enemies"):
		node.connect("dropLoot", summonLoot)

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

func summonLoot(pos: Vector2, val: int) -> void:
	var obj
	while val > 0:
		if val >= 5:
			obj = GOLD_COIN.instantiate() as CharacterBody2D
			val -= 5
		elif val >= 3:
			obj = SILVER_COIN.instantiate() as CharacterBody2D
			val -= 3
		else:
			obj = BRONZE_COIN.instantiate() as CharacterBody2D
			val -= 1
		
		obj.velocity.x = randf_range(-10, 10)
		obj.position = pos
		call_deferred("add_child", obj)
	
