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
	amountLabel.text = str(skillsMain.strengthPoints)
	interactable.writeTooltipTitle("Strength")
	interactable.writeTooltipContent(
		"Increases performance in strength
		steal.")

func _on_button_pressed() -> void:
	if skillsMain.points > 0 and skillsMain.strengthPoints < 10:
		skillsMain.strengthPoints += 1
		update()
		skillsMain.points -= 1
		pointCount.text = "Skill Points: " + str(skillsMain.points)
		PleaseSendHelp.buttonGotPressed.emit()

func addPoints(points:int):
	if skillsMain.points > 0 and skillsMain.strengthPoints < 10:
		skillsMain.strengthPoints += points
		update()

func tempBuff(points:int):
	tempPoints = points
	skillsMain.strengthPoints += points
	update()
	amountLabel.modulate = Color.GOLD
	
func resetBuff():
	skillsMain.strengthPoints -= tempPoints
	update()
	amountLabel.modulate = Color.WHITE
	tempPoints = 0

func update():
	skillsMain.strengthMod = (skillsMain.strengthPoints / 20.0) + 0.9
	amountLabel.text = str(skillsMain.strengthPoints)
