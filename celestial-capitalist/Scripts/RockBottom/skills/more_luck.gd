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
	amountLabel.text = str(skillsMain.luckPoints)
	interactable.writeTooltipTitle("Luck")
	interactable.writeTooltipContent(
		"Gives you better random events.")

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.luckPoints < 10:
		skillsMain.luckPoints += 1
		update()
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)

func addPoints(points:int):
	if skillsMain.points > 0 and skillsMain.luckPoints < 10:
		skillsMain.luckPoints += points
		update()

func tempBuff(points:int):
	tempPoints = points
	skillsMain.luckPoints += points
	update()
	amountLabel.modulate = Color.GOLD
	
func resetBuff():
	skillsMain.luckPoints -= tempPoints
	update()
	amountLabel.modulate = Color.WHITE
	tempPoints = 0

func update():
	skillsMain.luckMod = (skillsMain.luckPoints / 20.0) + 0.9
	amountLabel.text = str(skillsMain.luckPoints)
