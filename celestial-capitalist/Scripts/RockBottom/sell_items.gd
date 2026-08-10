extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")

signal openSellWind

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false:
		openSellWind.emit()
		outerSprite.scale = paddingSize
