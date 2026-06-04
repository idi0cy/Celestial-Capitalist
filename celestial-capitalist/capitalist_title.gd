extends Sprite2D

@onready var capitalistTimer = get_node("../Timers/capitalistTimer")
var movement = false

func _ready():
	capitalistTimer.start()

func _process(delta):
	if movement == true:
		position = position.lerp(Vector2(640, 320), delta*0.75)

func _on_capitalist_timer_timeout() -> void:
	movement = true
