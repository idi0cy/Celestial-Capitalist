extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openSellWind

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openSellWind.emit()
		outerSprite.scale = paddingSize
