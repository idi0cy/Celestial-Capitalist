extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")

signal openScavWind

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false:
		openScavWind.emit()
		outerSprite.scale = paddingSize
