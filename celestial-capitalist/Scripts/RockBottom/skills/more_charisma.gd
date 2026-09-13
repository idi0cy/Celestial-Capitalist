extends Node

#region | @onready variable declarations
@onready var skillsMain = get_node("../../../Skills")
@onready var buttonSprite = get_node("buttonSprite")
@onready var amountLabel = get_node("../amountLabel")
@onready var pointCount = get_node("../../pointCount")
@onready var interactable = get_node("interactable")
#endregion

var tempPoints:int = 0

func _ready():
	interactable.tooltipEnabled = true
	amountLabel.text = str(skillsMain.charismaPoints)
	interactable.writeTooltipTitle("Charisma")
	interactable.writeTooltipContent(
		"Increases performance in beg, con
		and haggle. Increases item qualities
		in market.")

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.charismaPoints < 10:
		skillsMain.charismaPoints += 1
		update()
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)
		PleaseSendHelp.buttonGotPressed.emit()

func addPoints(points:int):
	if skillsMain.points > 0 and skillsMain.charismaPoints < 10:
		skillsMain.charismaPoints += points
		update()

func tempBuff(points:int):
	tempPoints = points
	skillsMain.charismaPoints += points
	update()
	amountLabel.modulate = Color.GOLD
	
func resetBuff():
	skillsMain.charismaPoints -= tempPoints
	update()
	amountLabel.modulate = Color.WHITE
	tempPoints = 0

func update():
	skillsMain.charismaMod = (skillsMain.charismaPoints / 20.0) + 0.9
	amountLabel.text = str(skillsMain.charismaPoints)
	
