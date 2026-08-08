extends CCButton

signal highball

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	highball.emit()
	outerSprite.scale = paddingSize
