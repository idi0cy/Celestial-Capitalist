extends Node

func _ready():
	$loadingPopup.hide()

func _on_start_button_switch_scene() -> void:
	pass # Replace with function body.
	$loadingPopup.show()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://StageScenes/rock_bottom.tscn")
