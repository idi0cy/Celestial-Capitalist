extends Node2D

var itemSelected = false

func _process(_delta):
	if itemSelected == false:
		self.hide()
	else:
		self.show()
