extends Node2D

@onready var clock = get_node("../../../../digitalClock")

signal refresh(theValue)
var value

func _ready():
	value = 0
	pass

func _on_digital_clock_on_time_changed() -> void:
	value += 1
	if (value == 1440):
		value = 0
	refresh.emit(value)
