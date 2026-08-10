extends CCButton

signal begConfirm

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	begConfirm.emit()
	outerSprite.scale = paddingSize
