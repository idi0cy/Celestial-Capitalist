extends CCButton

signal stopBegging

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	stopBegging.emit()
	outerSprite.scale = paddingSize
