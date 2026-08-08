class_name HaggleMarker
extends ColorRect
## The line on the haggle bar which represents the player's current selected price.

@onready var haggle = get_node("../../../../Haggle")
var originalPos = Vector2(-148, -10)

func _process(_delta):
	position = Vector2((originalPos[0] + (haggle.selectedPrice * 0.01) * (290)), -10)
