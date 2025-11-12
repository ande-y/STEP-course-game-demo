extends CharacterBody2D

signal shoot
signal summon

const SKELETON = preload("res://scenes/enemies/skeleton.tscn")
const MAGE_SKELETON = preload("res://scenes/enemies/mage_skeleton.tscn")
var summonChoice = [SKELETON, MAGE_SKELETON]

var health: int = 400
var damage: int = 10

func shootProjectile():
	$AnimationPlayer.play("shoot")
func signalShoot():
	shoot.emit(Vector2.DOWN + Vector2(randf_range(-.5, .5), 0), $palm.global_position, damage)

func summonEnemy():
	$AnimationPlayer.play("summon")
func signalSummon():
	summon.emit($palm.global_position, summonChoice[randi_range(0,1)])
