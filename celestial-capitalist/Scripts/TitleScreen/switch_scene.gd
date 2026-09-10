extends Node

func _ready():
	$loadingPopup.hide()
	$tutorialPopup.hide()
	$startGamePopup.hide()

func _on_start_button_switch_scene() -> void:
	pass # Replace with function body.
	#$loadingPopup.show()
	#await get_tree().create_timer(0.5).timeout
	#get_tree().change_scene_to_file("res://StageScenes/rock_bottom.tscn")
	$startGamePopup.show()
	$tutorialPopup.hide()

func _on_start_from_tutorial_switch_scene_from_intro() -> void:
	$tutorialPopup.hide()
	$loadingPopup.show()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://StageScenes/rock_bottom.tscn")

func _on_get_the_context_get_context() -> void:
	$startGamePopup.hide()
	$tutorialPopup.show()

func _on_start_the_game_just_start() -> void:
	$startGamePopup.hide()
	$loadingPopup.show()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://StageScenes/rock_bottom.tscn")
