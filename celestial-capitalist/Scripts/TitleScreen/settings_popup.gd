extends Node2D

@onready var slider = get_node("HSlider")
@onready var text = get_node("Label")

@export 
var bus_name : String

var bus_index : int

func _ready():
	bus_index = AudioServer.get_bus_index("UI")
	hide()

func _on_h_slider_changed() -> void:
	#text = str("UI Sound: " + slider.value + "%")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(slider.value))

func _on_h_slider_value_changed(value: float) -> void:
	text.text = str("UI Sound: " + str(snapped(slider.value*100, 1)) + "%")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(slider.value))

func _on_button_pressed() -> void:
	hide()

func _on_settings_button_open_settings() -> void:
	show()


func _on_get_the_context_get_context() -> void:
	pass # Replace with function body.
