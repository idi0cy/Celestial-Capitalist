extends ColorRect

@onready var con = get_node("../../../../Con")
var originalPos = Vector2(-148, -10)

func update():
	position = Vector2((originalPos[0] + (con.risk * 0.01) * (290)), -10)
