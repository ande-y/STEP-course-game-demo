extends CanvasLayer

const FOREST_LEVEL = preload("res://scenes/levels/forest_level.tscn")
const coinsLost = 50

func restartLevel():
	if Globals.coins - coinsLost < 0:
		$Label.text = "YOU DIED !
					not enough coins !
					you're starting over !"
	else:
		$Label.text = "YOU DIED !
					-" + str(coinsLost) +" Coins"
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	Globals.health = 100
	Globals.energy = 100
	if Globals.coins - coinsLost < 0:
		get_tree().change_scene_to_packed(FOREST_LEVEL)
		Globals.coins = 0
		Globals.minute = 0
		Globals.second = 0
	else:
		get_tree().reload_current_scene()
		Globals.coins -= coinsLost
	$AnimationPlayer.play_backwards("fade")

func nextLevel(target: PackedScene):
	$Label.text = ""
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	if Globals.health <= 0:
		restartLevel()
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("fade")
