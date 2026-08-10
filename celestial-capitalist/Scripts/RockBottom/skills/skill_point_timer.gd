extends Node2D

@onready var skillMain = get_node("../../Skills")
@onready var timer = get_node("tillNextPoint")
@onready var label = get_node("Label")
@onready var pointCount = get_node("../pointCount")
@onready var progress = get_node("progressDisplay")

var keptCount = 180

func _ready():
	timer.start()

#func _process(delta):
	#label.text = "(" + str(keptCount) + " Seconds) Until New Skill Point"

func _on_till_next_point_timeout() -> void:
	keptCount -= 1
	label.text = "(" + str(keptCount) + " Seconds) Until New Skill Point"
	progress.value = ((180-keptCount) / 180.0) * 100
	if keptCount <= 0:
		keptCount = 180
		skillMain.points += 1
		pointCount.text = "Skill Points: " + str(skillMain.points)
