extends HBoxContainer

@onready var itemLabel = get_node("Item")
@onready var qualityLabel = get_node("Quality")
@onready var valueLabel = get_node("Value")
@onready var InvGrid = get_node("../InvGrid")

var nameSize
var qualSize
var valSize
var labelSizeComb

var itemSelected = false

func _process(_delta):
	if itemSelected == false:
		self.hide()
	else:
		self.show()
	organize()

func organize():
	nameSize = itemLabel.size.x
	qualSize = qualityLabel.size.x
	valSize = valueLabel.size.x
	labelSizeComb = valSize + qualSize + nameSize
	var placeHolder: int = int((500 - labelSizeComb)/2)
	add_theme_constant_override("separation", placeHolder)
