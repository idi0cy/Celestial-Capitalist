extends CCButton

@onready var sellWindow = get_node("../../CenterWindows/sellWind")

signal openQuota

func _ready():
	pass

func _on_interactable_pressed() -> void:
	if sellWindow.initiatingAction == false:
		openQuota.emit()
		outerSprite.scale = paddingSize
