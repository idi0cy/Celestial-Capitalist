extends ProgressBar

@onready var beg = get_node("../../Beg")

func _process(_delta):
	if beg.finishing == false:
		value = beg.begProgress
