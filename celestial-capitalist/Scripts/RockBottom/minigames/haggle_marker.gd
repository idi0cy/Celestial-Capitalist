extends ColorRect

@onready var haggle = get_node("../../../../Haggle")
var originalPos = Vector2(-148, -10)

func _process(_delta):
	position = Vector2((originalPos[0] + (haggle.ballSpectrum * 0.01) * (290)), -10)
