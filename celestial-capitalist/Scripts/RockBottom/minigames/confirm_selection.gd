class_name ConfirmSell
extends CCButton
## Confirms the item to sell in [PickToSell] screen.

@onready var pickToSell = get_node("../../pickToSell")

## The currently selected assembled item.
var selected
## The index of the selected item in the invGrid.
var selectedIndex
## Whether the button is shown or hidden.
var hiding = true

signal confirmSelection

func _ready():
	pass

func _process(_delta):
	if hiding == true:
		self.hide()
	else:
		self.show()
	super._process(_delta)

func _on_interactable_pressed() -> void:
	hiding = true
	pickToSell.hiding = true
	confirmSelection.emit()
	outerSprite.scale = paddingSize
