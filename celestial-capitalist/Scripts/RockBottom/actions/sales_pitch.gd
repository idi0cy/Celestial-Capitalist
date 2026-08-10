extends CCButton

@onready var takeAction = get_node("../takeAction")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")

signal salesPitch

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWind.initiatingAction == false:
		takeAction.action = "Sales Pitch"
		terminalText.targetText = "> System: Sell an item to this stranger. Minigame performance partially determines success."
		terminalText.fillText()
		salesPitch.emit()
		outerSprite.scale = paddingSize
