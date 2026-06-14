extends ProgressBar

@onready var beg = get_node("../../Beg")

func _process(_delta):
	value = beg.begProgress
