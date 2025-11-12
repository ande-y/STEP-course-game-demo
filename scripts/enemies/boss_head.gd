extends CharacterBody2D

var health: int = 600

func _on_left_timeout() -> void:
	var choice: int = randi_range(1, 2)
	if choice == 1:
		$"boss hand right".shootProjectile()
	elif choice == 2:
		$"boss hand right".summonEnemy()
		
	$left.wait_time = randf_range(8, 12)

func _on_right_timeout() -> void:
	var choice: int = randi_range(1, 2)
	if choice == 1:
		$"boss hand left".shootProjectile()
	elif choice == 2:
		$"boss hand left".summonEnemy()
		
	$right.wait_time = randf_range(8, 12)
