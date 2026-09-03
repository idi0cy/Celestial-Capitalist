extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openLog

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openLog.emit()
		outerSprite.scale = paddingSize
