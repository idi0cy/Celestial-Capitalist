extends Node

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	#print(self)
	get_parent().hide()
	get_parent().tutorialEngaged = false
	get_parent().tutorialStage = 0
	get_node("../name").hide()
	get_node("../startFromTutorial").hide()
