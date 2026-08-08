extends CCButton

@onready var takeAction = get_node("../takeAction")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")

signal fakeInjury

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWind.initiatingAction == false:
		takeAction.action = "Fake Injury"
		terminalText.targetText = "> System: Convince the target they have mortally wounded you, or convince the public to pressure them. Demand compensation."
		terminalText.fillText()
		fakeInjury.emit()
		outerSprite.scale = paddingSize
