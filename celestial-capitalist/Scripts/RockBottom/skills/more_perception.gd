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
	amountLabel.text = str(skillsMain.percPoints)
	interactable.writeTooltipTitle("Perception")
	interactable.writeTooltipContent(
		"Increases loot quality in scavenge.")

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.percPoints < 10:
		skillsMain.percPoints += 1
		update()
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)
		PleaseSendHelp.buttonGotPressed.emit()

func addPoints(points:int):
	if skillsMain.points > 0 and skillsMain.percPoints < 10:
		skillsMain.percPoints += points
		update()

func tempBuff(points:int):
	tempPoints = points
	skillsMain.percPoints += points
	update()
	amountLabel.modulate = Color.GOLD
	
func resetBuff():
	skillsMain.percPoints -= tempPoints
	update()
	amountLabel.modulate = Color.WHITE
	tempPoints = 0

func update():
	skillsMain.percMod = (skillsMain.percPoints / 20.0) + 0.9
	amountLabel.text = str(skillsMain.percPoints)
