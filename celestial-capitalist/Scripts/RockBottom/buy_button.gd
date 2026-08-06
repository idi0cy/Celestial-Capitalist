extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")

signal openShop

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false:
		openShop.emit()
		outerSprite.scale = paddingSize
