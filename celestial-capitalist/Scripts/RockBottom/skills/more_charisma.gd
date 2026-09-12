extends Node

#region | @onready variable declarations
@onready var skillsMain = get_node("../../../Skills")
@onready var buttonSprite = get_node("buttonSprite")
@onready var amountLabel = get_node("../amountLabel")
@onready var pointCount = get_node("../../pointCount")
@onready var interactable = get_node("interactable")
#endregion

func _ready():
	amountLabel.text = str(skillsMain.charismaPoints)
	interactable.writeTooltipTitle("Charisma")
	interactable.writeTooltipContent(
		"Increases performance in beg, con
		and haggle.")

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.charismaPoints < 10:
		skillsMain.charismaPoints += 1
		skillsMain.charismaMod = (skillsMain.charismaPoints / 20.0) + 0.9
		amountLabel.text = str(skillsMain.charismaPoints)
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)
		PleaseSendHelp.buttonGotPressed.emit()
