extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openLedger

func _ready():
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Faults on Display")
	interactable.writeTooltipContent(
		"Tracks and displays your balance
		daily in/outcome, and any change
		to your balance.")

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openLedger.emit()
		outerSprite.scale = paddingSize
