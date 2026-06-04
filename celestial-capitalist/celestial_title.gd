extends Sprite2D

@onready var celestialTimer = get_node("../Timers/celestialTimer")
var movement = false

func _ready():
	celestialTimer.start()

func _process(delta):
	if movement == true:
		position = position.lerp(Vector2(640, 320), delta*0.75)

func _on_celestial_timer_timeout() -> void:
	movement = true
