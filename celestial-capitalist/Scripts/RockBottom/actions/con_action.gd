extends CCButton

@onready var takeAction = get_node("../takeAction")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")

signal conning

func _ready():
	pass
	
func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWind.initiatingAction == false:
		takeAction.action = "Con"
		terminalText.targetText = "> System: Get the target to bet their money on a shady venture."
		terminalText.fillText()
		conning.emit()
		outerSprite.scale = paddingSize
