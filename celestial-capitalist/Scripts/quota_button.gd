extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openQuota

func _ready():
	interactable.writeTooltipTitle("Progression Quota")
	interactable.writeTooltipContent(
		"Fill out these goals to progress
		to the next stage.")

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openQuota.emit()
	super()
