class_name ItemDesc
extends Node2D
## The [Terminal] overlay that shows item details.
##
## Most processing is done in the parent [InventoryHelper] inventory class. This class only covers show/hide conditions.

## False will hide, vice versa.
var itemSelected = false

## Determines whether to show or hide [ItemDesc] based on [member ItemDesc.itemSelected].
func _process(_delta):
	if itemSelected == false:
		hide()
	else:
		show()
