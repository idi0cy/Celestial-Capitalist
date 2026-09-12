extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openScavWind

func _ready():
	interactable.writeTooltipTitle("Delittering")
	interactable.writeTooltipContent(
		"Scavenge stuff off the street for your
		own purposes. Loot quality increases
		with your balance and refreshes over
		time. The rich get richer!")

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openScavWind.emit()
	super()
