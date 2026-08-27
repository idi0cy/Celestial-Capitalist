extends Node2D

func _ready():
	hide()

func _on_button_pressed() -> void:
	hide()

func _on_settings_button_open_settings() -> void:
	show()
