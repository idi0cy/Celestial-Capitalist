extends Node2D

@onready var severitySelection = get_node("severityPick")

var severity = 50
var targetIndex

func initiate(target):
	targetIndex = target
	severity = 50
	severitySelection.show()
	show()

func _on_lower_lower_severity() -> void:
	if (severity - 10) >= 0:
		severity -= 10

func _on_raise_raise_severity() -> void:
	if (severity + 10) <= 100:
		severity += 10
