extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openScavWind

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openScavWind.emit()
		outerSprite.scale = paddingSize
