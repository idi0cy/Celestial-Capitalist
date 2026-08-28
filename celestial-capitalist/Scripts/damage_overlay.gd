extends Sprite2D
var tween

func _ready() -> void:
	modulate.a = 0.0

func fade(health:int):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.01 * (100 - health), 1.5)
	tween.tween_interval(0.25)
	tween.tween_property(self, "modulate:a", 0.0, 1.5)
