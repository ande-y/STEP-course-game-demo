extends Node2D
class_name level

const BRONZE_COIN = preload("res://scenes/items/bronze_coin.tscn")
const SILVER_COIN = preload("res://scenes/items/silver_coin.tscn")
const GOLD_COIN = preload("res://scenes/items/gold_coin.tscn")

const RED_POTION = preload("res://scenes/items/red_potion.tscn")
const BLUE_POTION = preload("res://scenes/items/blue_potion.tscn")
const PURPLE_POTION = preload("res://scenes/items/purple_potion.tscn")

const PURPLE_MAGIC = preload("res://scenes/projectile/purple_magic.tscn")
const RED_MAGIC = preload("res://scenes/projectile/red_magic.tscn")
const FLYING_SLASH = preload("res://scenes/projectile/flying_slash.tscn")

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("enemies can shoot"):
		node.connect("shoot", enemyShoot)
	for node in get_tree().get_nodes_in_group("enemies can slash"):
		node.connect("slash", enemySlash)
	for node in get_tree().get_nodes_in_group("drop loot"):
		node.connect("dropCoin", summonCoin)
		node.connect("dropPotion", summonPotion)
	for node in get_tree().get_nodes_in_group("environment hazard summoner"):
		node.connect("dripProjectile", drip)
	for node in get_tree().get_nodes_in_group("enemies can summon"):
		node.connect("summon", summon)

func _on_player_player_magic(dir: Vector2, pos: Vector2) -> void:
	#for i in 10:
		var obj = PURPLE_MAGIC.instantiate() as Area2D
		obj.direction = dir#.rotated(randf_range(-.4, .4))
		obj.position = pos
		add_child(obj)

func enemyShoot(dir: Vector2, pos: Vector2, dmg: int) -> void:
	var obj = RED_MAGIC.instantiate() as Area2D
	obj.direction = dir
	obj.position = pos
	obj.damage = dmg
	add_child(obj)
	
func enemySlash(dir: Vector2, pos: Vector2, dmg: int) -> void:
	var obj = FLYING_SLASH.instantiate() as Area2D
	obj.rotation = dir.angle()
	obj.direction = dir
	obj.position = pos
	obj.damage = dmg
	add_child(obj)
	
func drip(pos: Vector2, pack: PackedScene):
	var obj = pack.instantiate() as Area2D
	obj.direction = Vector2.DOWN
	obj.position = pos
	add_child(obj)
	
func summonCoin(pos: Vector2, val: int) -> void:
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
		
		obj.velocity.x = randf_range(-100, 100)
		obj.position = pos
		call_deferred("add_child", obj)
		
func summonPotion(pos: Vector2, r: float, b: float):
	var chance = randf_range(0, 1)
	var obj
	if (r > chance and b > chance):
		obj = PURPLE_POTION.instantiate() as CharacterBody2D
	elif (r > chance):
		obj = RED_POTION.instantiate() as CharacterBody2D
	elif (b > chance):
		obj = BLUE_POTION.instantiate() as CharacterBody2D
	else:
		return
		
	obj.velocity.x = randf_range(-100, 100)
	obj.position = pos
	call_deferred("add_child", obj)
	
func summon(pos: Vector2, pack: PackedScene):
	var obj = pack.instantiate() as CharacterBody2D
	obj.position = pos
	add_child(obj)
	if obj.is_in_group("enemies can shoot"):
		obj.connect("shoot", enemyShoot)
	if obj.is_in_group("enemies can slash"):
		obj.connect("slash", enemySlash)

	
func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
