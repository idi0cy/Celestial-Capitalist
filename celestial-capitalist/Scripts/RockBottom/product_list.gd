extends HBoxContainer

@export var productListHidden = true
var takenSpace = 0
var anotherAnotherPlaceholder #just soak this variable in. Let it marinate.
var count

func _process(_delta):
	if productListHidden == true:
		self.hide()
	else:
		self.show()
	#organize()

func organize():
	count = 0
	for item in self.get_children():
		takenSpace += item.size.x
		count += 1
	if count - 1 <= 0:
		var placeHolder = 0
		anotherAnotherPlaceholder = placeHolder
	else:
		var placeHolder: int = int((500-takenSpace)/(count - 1))
		anotherAnotherPlaceholder = placeHolder
	var anotherPlaceHolder = anotherAnotherPlaceholder
	add_theme_constant_override("separation", anotherPlaceHolder)
