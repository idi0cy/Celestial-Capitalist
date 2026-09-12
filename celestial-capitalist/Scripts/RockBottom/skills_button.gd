extends CCButton
@onready var sellWindow = get_node("../../CenterWindows/sellWind")
@onready var scavenge = get_node("../../CenterWindows/scavenge")

signal openSkillTree

func _ready():
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Skills for Bills")
	interactable.writeTooltipContent(
		"Level various stats to improve your
		performance in minigames. Skill 
		points are ganed by playing minigames")

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	if sellWindow.initiatingAction == false && scavenge.scavengeActive == false:
		openSkillTree.emit()
		outerSprite.scale = paddingSize
