extends ProgressBar

@onready var clock = get_node("../../../../digitalClock")

var placeholder = 0
signal whyDoINeedThis(theValue)

func _ready():
	pass
	#placeholder = clock.theTime % 30
	#value = placeholder
	#whyDoINeedThis.emit(value)

func _on_digital_clock_on_time_changed() -> void:
	placeholder = clock.theTime % 30
	value = placeholder
	whyDoINeedThis.emit(value)
