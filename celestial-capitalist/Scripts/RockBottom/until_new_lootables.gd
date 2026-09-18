extends ProgressBar

@onready var clock = get_node("../../../../digitalClock")

signal refresh(theValue)

var maxStep:int = 100

func _ready():
	value = 0
	pass

func _on_digital_clock_on_time_changed() -> void:
	value += maxStep
	if (value == 100):
		value = 0
	refresh.emit(value)
