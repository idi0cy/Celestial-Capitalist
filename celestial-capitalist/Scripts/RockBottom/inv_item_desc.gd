extends Node2D

var itemSelected = false
var selectedItem:Array
@onready var useButton = get_node("button")

func _process(_delta):
	if itemSelected == false:
		self.hide()
	else:
		self.show()
		if (selectedItem):
			if (selectedItem[1] == "Currency" || selectedItem[1] == "Consumable"):
				useButton.show()
			else:
				useButton.hide()
