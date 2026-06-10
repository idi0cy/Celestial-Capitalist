extends Node2D

@onready var haggleBar = get_node("haggleBar")

@onready var progress = haggleBar.haggleProgress

var redBar = StyleBoxFlat.new()
var greenBar = StyleBoxFlat.new()

func _ready():
	redBar.bg_color = Color(1.0, 0.353, 0.0, 1.0)
	greenBar.bg_color = Color(0.387, 1.0, 0.356, 1.0)

func _process(_delta):
	progress = haggleBar.haggleProgress
	if progress < 50:
		haggleBar.add_theme_stylebox_override("fill", redBar)
	else:
		haggleBar.add_theme_stylebox_override("fill", greenBar)
