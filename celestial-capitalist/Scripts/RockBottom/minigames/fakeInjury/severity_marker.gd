extends ColorRect

@onready var fakeInjury = get_node("../../../FakeInjury")
var originalPos = Vector2(428, 298)

func _process(_delta):
	position = Vector2((originalPos[0] + (fakeInjury.severity * 0.01) * (290)), 298)
