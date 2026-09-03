extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openShop

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openShop.emit()
		outerSprite.scale = paddingSize
