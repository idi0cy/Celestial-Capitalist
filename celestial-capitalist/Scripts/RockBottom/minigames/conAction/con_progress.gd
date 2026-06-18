extends ProgressBar

@onready var myParent = get_parent()

func _process(_delta):
	value = myParent.trustProgress
