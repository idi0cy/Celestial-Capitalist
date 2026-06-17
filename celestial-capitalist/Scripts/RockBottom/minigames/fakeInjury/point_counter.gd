extends Label

@onready var minigamePart = get_node("../../../minigamePart")

func _process(_delta):
	text = str(minigamePart.points)
