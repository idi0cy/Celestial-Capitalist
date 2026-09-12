extends CCButton

signal promote

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	promote.emit()
	super()
