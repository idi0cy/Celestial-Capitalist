extends CCButton

@onready var takeAction = get_node("../takeAction")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")

signal stealStuff

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWind.initiatingAction == false:
		takeAction.action = "Steal"
		terminalText.targetText = "> System: Take the target's possessions without their consent."
		terminalText.fillText()
		stealStuff.emit()
		outerSprite.scale = paddingSize
