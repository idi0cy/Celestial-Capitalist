class_name Interactable
extends Button
## A script for interactables with the [class CCButton] template scene. Controls tooltips. [br]
## [br]
## The methods below [method setContentColour], [method setTitleColour], [method writeTooltipContent], 
## [method writeTooltipTitle] are meant to be called externally from the parent [class CCButton]. 
## Call at ready to set a default tooltip.

## The tooltip template scene.
const tooltip = preload("res://ButtonScenes/tooltip.tscn")

var tooltipContent : String = ""
var tooltipTitle : String = ""
var contentColour : Color = Color(1.0, 1.0, 1.0, 1.0)
var titleColour : Color = Color(1.0, 1.0, 1.0, 1.0)

func _make_custom_tooltip(_content:String) -> Control:
	var tooltipInstance = tooltip.instantiate()
	tooltipInstance.setText(tooltipTitle, tooltipContent)
	tooltipInstance.get_node("control/title").modulate = titleColour
	tooltipInstance.get_node("control/content").modulate = contentColour
	return tooltipInstance

func setContentColour(color:Color):
	contentColour = color
	
func setTitleColour(color:Color):
	titleColour = color

func writeTooltipContent(content:String):
	tooltipContent += content

func writeTooltipTitle(title:String):
	tooltipTitle = title
