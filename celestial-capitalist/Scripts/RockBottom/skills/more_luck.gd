extends Node

#region | @onready variable declarations
@onready var skillsMain = get_node("../../../Skills")
@onready var buttonSprite = get_node("buttonSprite")
@onready var amountLabel = get_node("../amountLabel")
@onready var pointCount = get_node("../../pointCount")
#endregion

func _ready():
	amountLabel.text = str(skillsMain.luckPoints)

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.luckPoints < 10:
		skillsMain.luckPoints += 1
		skillsMain.luckMod = (skillsMain.luckPoints / 20.0) + 0.9
		amountLabel.text = str(skillsMain.luckPoints)
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)
