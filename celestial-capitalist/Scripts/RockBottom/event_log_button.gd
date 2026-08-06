extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")

signal openLog

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false:
		openLog.emit()
		outerSprite.scale = paddingSize
