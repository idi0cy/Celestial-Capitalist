extends CCButton

@onready var terminalText = get_node("../../../../Terminal/termText")

signal pathos

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	terminalText.targetText = "> System: Use language to maximise the target's empathetic output."
	terminalText.fillText()
	pathos.emit()
	outerSprite.scale = paddingSize
