extends Node
const tooltip = preload("res://ButtonScenes/tooltip.tscn")
var tooltipText = ""

func _make_custom_tooltip(for_text:String) -> Control:
	var tooltipInstance = tooltip.instantiate()
	for_text = tooltipText
	tooltipInstance.setText("Daily Costs", for_text)
	tooltipInstance.get_node("control/content").modulate = Color(1, 0, 0)
	return tooltipInstance

func writeValues(amount, source):
	tooltipText += "- $" + str(abs(amount)) + " to " + source + "\n"
