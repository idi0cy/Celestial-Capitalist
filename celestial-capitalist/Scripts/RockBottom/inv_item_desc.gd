class_name InvItemDesc
extends ItemDesc
## The [Terminal] overlay that shows item details.
##
## Most processing is done in the parent [InventoryHelper] inventory class. This class only covers show/hide conditions.

## Should store the currently selected base item, not assembled item. Used to determine whether to show the use item button based on item type.
var selectedItem:Array
## Use Item [Button].
@onready var useButton = get_node("button")

## Determines whether to show or hide [ItemDesc] based on [member ItemDesc.itemSelected].
func _process(_delta):
	if itemSelected == false:
		hide()
	else:
		show()
		if (selectedItem):
			if (selectedItem[1] == "Currency" || selectedItem[1] == "Consumable"):
				useButton.show()
			else:
				useButton.hide()
