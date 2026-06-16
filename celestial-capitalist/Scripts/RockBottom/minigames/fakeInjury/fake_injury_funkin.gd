extends Node2D

@onready var terminalText = get_node("../../../Terminal/termText")

var time

func initiate(repeats):
	time = 2.0/repeats
	show()
	terminalText.targetText = "> System: You know about friday night funkin, right? I'm sure you'll get the hang of it."
	terminalText.fillText()
	await get_tree().create_timer(3).timeout
	
	for i in repeats:
		pass
		
