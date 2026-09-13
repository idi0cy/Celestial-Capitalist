extends Node

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	#print(self)
	get_parent().hide()
	get_parent().tutorialEngaged = false
	get_parent().tutorialStage = 0
	get_parent().typingName = false
	get_parent().lastScreen = false
	get_parent().check = 0
	get_parent().nameWrite.hide()
	get_parent().clickPrompt.show()
	get_parent().startButton.hide()
	get_parent().startButton.modulate.a = 0
