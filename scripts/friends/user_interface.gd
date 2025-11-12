extends CanvasLayer

@onready var coin_counter: Label = $"MarginContainer2/HBoxContainer/coin counter"
@onready var health_bar: TextureProgressBar = $"MarginContainer/VBoxContainer/HBoxContainer/health bar"
@onready var energy_bar: TextureProgressBar = $"MarginContainer/VBoxContainer/HBoxContainer2/energy bar"

func _ready() -> void:
	Globals.connect("updateUI", updateEverything)
	Globals.connect("updateTime", updateTime)
	updateEverything()
	
func updateTime(strMin: String, strSec: String):
	$MarginContainer3/time.text = strMin + ":" + strSec
	
func updateEverything():
	health_bar.value = Globals.health
	energy_bar.value = Globals.energy
	if Globals.coins != 1:
		coin_counter.text = str(Globals.coins) + " coins" 
	else:
		coin_counter.text = str(Globals.coins) + " coin"
