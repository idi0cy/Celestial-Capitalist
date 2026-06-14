extends ProgressBar

@onready var haggle = get_node("../../Haggle")
@export var haggleProgress = 0

func _process(_delta):
	value = haggle.progress
