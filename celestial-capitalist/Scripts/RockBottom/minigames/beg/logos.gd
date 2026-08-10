extends CCButton

@onready var terminalText = get_node("../../../../Terminal/termText")

signal logos

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	terminalText.targetText = "> System: Use your logical faculties to convince this stranger to donate to you."
	terminalText.fillText()
	logos.emit()
	outerSprite.scale = paddingSize
