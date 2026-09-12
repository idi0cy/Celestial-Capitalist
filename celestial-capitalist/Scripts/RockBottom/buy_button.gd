extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openShop

func _ready():
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Spending Habits")
	interactable.writeTooltipContent(
		"Buy from a friendly street stall!
		Prices vary and a different stall
		appears every day.")

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openShop.emit()
	super()
