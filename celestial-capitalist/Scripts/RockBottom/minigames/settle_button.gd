extends CCButton

signal ball

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	ball.emit()
	outerSprite.scale = paddingSize
