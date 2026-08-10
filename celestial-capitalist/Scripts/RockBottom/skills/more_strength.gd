extends Node

#region | @onready variable declarations
@onready var skillsMain = get_node("../../../Skills")
@onready var buttonSprite = get_node("buttonSprite")
@onready var amountLabel = get_node("../amountLabel")
@onready var pointCount = get_node("../../pointCount")
#endregion

func _ready():
	amountLabel.text = str(skillsMain.strengthPoints)

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.strengthPoints < 10:
		skillsMain.strengthPoints += 1
		skillsMain.strengthMod = (skillsMain.strengthPoints / 20.0) + 0.9
		amountLabel.text = str(skillsMain.strengthPoints)
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)
