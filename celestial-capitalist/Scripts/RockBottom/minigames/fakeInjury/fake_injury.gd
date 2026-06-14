extends Node2D

@onready var severitySelection = get_node("severityPick")
@onready var FIbox = get_node("FIbox")
@onready var theGuy = get_node("../../theGuy")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")
@onready var ledger = get_node("../../../../Ledger")
@onready var allStrangers = sellWind.allStrangers

var severity = 50
var targetIndex
var random
var arguedVal = 0

func initiate(target):
	targetIndex = target
	arguedVal = 0
	severity = 50
	severitySelection.show()
	show()

func _on_settle_settle_severity() -> void:
	severitySelection.hide()
	FIbox.hide()
	theGuy.show()
	if severity < 25:
		terminalText.targetText = "> You: Hey, you stepped on my foot, what the heck?! Give me a dollar."
		arguedVal = 1
	elif severity < 50:
		terminalText.targetText = "> You: Hey, you stepped on my arm, what the heck?! Give me three dollars."
		arguedVal = 3
	elif severity < 75:
		terminalText.targetText = "> You: Hey, you stepped on my chest and I think you broke my clavicle, what the heck?! Give me ten dollars."
		arguedVal = 10
	else:
		terminalText.targetText = "> You: Hey, you stepped on my sould and I think you broke a bit of it, what the heck?! Give me twenty dollars."
		arguedVal = 20
	terminalText.fillText()
	await get_tree().create_timer(2.0).timeout
	
	random = randf()
	if random * allStrangers[targetIndex][5] * (1.0 - (severity / 100.0)) > (severity/100.0):
		ledger.money += arguedVal
		terminalText.targetText = "> " + str(allStrangers[targetIndex][0]) + ": Okay, take $" + str(arguedVal) + "."
	else:
		terminalText.targetText = "> " + str(allStrangers[targetIndex][0]) + ": Uhh, you're not even injured."
	terminalText.fillText()
	await get_tree().create_timer(1.5).timeout
	

func _on_lower_lower_severity() -> void:
	if (severity - 10) >= 0:
		severity -= 10

func _on_raise_raise_severity() -> void:
	if (severity + 10) <= 100:
		severity += 10
