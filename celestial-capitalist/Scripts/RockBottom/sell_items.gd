extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openSellWind

func _ready():
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Social Interaction")
	interactable.writeTooltipContent(
		"Talk to strangers and attempt to
		coerce money out of them through
		various means.")

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openSellWind.emit()
	super()
