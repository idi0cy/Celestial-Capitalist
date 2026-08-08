extends CCButton

signal fearMonger

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	fearMonger.emit()
	outerSprite.scale = paddingSize
