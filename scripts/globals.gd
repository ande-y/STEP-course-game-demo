extends Node

signal updateUI

# anything within this file is accessible by any & all scripts in this project

var health: int = 100:
	set(value):
		health = value
		updateUI.emit()

var energy: int = 100:
	set(value):
		energy = value
		updateUI.emit()
		
var playerPosition: Vector2
