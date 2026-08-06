extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")

signal openInventory

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false:
		openInventory.emit()
		outerSprite.scale = paddingSize
