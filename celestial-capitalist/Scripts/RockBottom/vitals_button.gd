extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openVitals

func _ready():
	interactable.writeTooltipTitle("Health Goals")
	interactable.writeTooltipContent(
		"Displays your vital signs. If your
		satiation decreases, your max health
		also decreases. If your hydration
		hits zero, take damage over time.")

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openVitals.emit()
	super()
