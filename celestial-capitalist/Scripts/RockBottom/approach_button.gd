extends CCButton

signal approachStranger

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	approachStranger.emit()
	outerSprite.scale = paddingSize
