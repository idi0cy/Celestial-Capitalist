extends Node2D

var health:int = 100
var hydration:int = 100
var satiation:int = 100
var hydrationTimeLeft: float = 1.0
var satiationTimeLeft: float = 1.0

func _process(delta: float):
	hydrationTimeLeft -= delta
	satiationTimeLeft -= delta
	if hydrationTimeLeft <= 0.0:
		hydrationTimeLeft += 45.0
		hydration -= 1
	if satiationTimeLeft <= 0.0:
		satiationTimeLeft += 100.0
		satiation -= 1

func _ready() -> void:
	pass

func _input(event):
	if event.is_action_pressed("debug"):
		print(health)
		print(hydration)
		print(satiation)
