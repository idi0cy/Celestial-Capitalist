extends CCButton

signal lowball

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	lowball.emit()
	outerSprite.scale = paddingSize
