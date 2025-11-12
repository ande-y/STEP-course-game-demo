extends Node

signal updateUI
signal updateTime

# anything within this file is accessible by any & all scripts in this project

var health: int = 1000000:
	set(value):
		health = value
		#if health > 100:
			#health = 100
		updateUI.emit()

var energy: int = 100:
	set(value):
		energy = value
		if energy > 100:
			energy = 100
		updateUI.emit()
		
var coins: int = 0:
	set(value):
		coins = value
		updateUI.emit()
		
var playerPosition: Vector2


var minute: int = 0
var second: float = 0

func _process(delta: float) -> void:
	var priorSec = second
	var newMin: bool = false
	
	second += delta
	if second >= 60:
		minute += 1
		second = 0
		newMin = true
	
	if int(second) > int(priorSec) or newMin:
		var strMin: String = str(minute)
		if minute < 10:
			strMin = "0" + strMin
		var strSec: String = str(int(second))
		if second < 10:
			strSec = "0" + strSec
		updateTime.emit(strMin, strSec)
