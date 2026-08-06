extends CCButton

@onready var takeAction = get_node("../takeAction")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")

signal begging

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWind.initiatingAction == false:
		takeAction.action = "Beg"
		terminalText.targetText = "> System: Guilt trip the target into providing you with fiscal relief."
		terminalText.fillText()
		begging.emit()
		outerSprite.scale = paddingSize
