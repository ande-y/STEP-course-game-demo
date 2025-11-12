extends CanvasLayer

@onready var health_bar: TextureProgressBar = $"MarginContainer/VBoxContainer/HBoxContainer/health bar"
@onready var energy_bar: TextureProgressBar = $"MarginContainer/VBoxContainer/HBoxContainer2/energy bar"

func _ready() -> void:
	Globals.connect("updateUI", updateEverything)
	updateEverything()
	
func updateEverything():
	health_bar.value = Globals.health
	energy_bar.value = Globals.energy
