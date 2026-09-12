extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openInventory

func _ready():
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Infinite Storage!")
	interactable.writeTooltipContent(
		"Despite being homeless, you appear
		to have obtained a bottomless space
		to store your items. You may also
		directly use them from inside it.")

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openInventory.emit()
	super()
