extends CCButton

@onready var terminalText = get_node("../../../../Terminal/termText")

signal ethos

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	terminalText.targetText = "> System: Use your esteemed authority as a homeless person to convince this stranger to donate to you."
	terminalText.fillText()
	ethos.emit()
	outerSprite.scale = paddingSize
