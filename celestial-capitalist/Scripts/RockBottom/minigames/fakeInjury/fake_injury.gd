extends Node2D

@onready var severitySelection = get_node("severityPick")
@onready var FIbox = get_node("FIbox")
@onready var theGuy = get_node("../../theGuy")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWind = get_node("../../../../sellWind")
@onready var ledger = get_node("../../../../Ledger")
@onready var minigame = get_node("minigamePart")
@onready var clock = get_node("../../../../../digitalClock")
@onready var dialogueLib = get_node("../../minigameWindows")
@onready var peopleList = get_node("../../../../sellWind/PickTarget/PeopleList")

@onready var blackmailIcon = load("res://assets/Sprites/RockBottom/ledgerWindow/blackmail.png")

var severity = 50
var targetIndex
var random
var arguedVal = 0
var storedStrangerIndex : int

func initiate(target):
	targetIndex = target
	arguedVal = 0
	severity = 50
	severitySelection.show()
	FIbox.show()
	minigame.hide()
	show()

func _on_settle_settle_severity() -> void:
	minigamePart()

func minigamePart():
	theGuy.hide()
	severitySelection.hide()
	FIbox.show()
	if severity > 0:
		minigame.initiate(severity)
	else:
		minigame.initiate(1)

func arbitration(points):
	#print("arbitrating")
	severitySelection.hide()
	FIbox.hide()
	theGuy.show()
	if severity < 25:
		terminalText.targetText = "> You: Hey, you stepped on my foot, what the heck?! Give me money, or I'll tell everyone."
	elif severity < 50:
		terminalText.targetText = "> You: Hey, you stepped on my arm, what the heck?! Give me money, or I'll tell everyone."
	elif severity < 75:
		terminalText.targetText = "> You: Hey, you stepped on my chest and I think you broke my clavicle, what the heck?! Give me money or I'll tell everyone."
	else:
		terminalText.targetText = "> You: Hey, you stepped on my soul and I think you broke a bit of it, what the heck?! Give me money or I'll tell everyone."
	arguedVal = severity * 0.1
	terminalText.fillText()
	await get_tree().create_timer(3.0).timeout
	
	var regex = RegEx.new()
	regex.compile("\\d")
	var generatedName = peopleList.get_child(storedStrangerIndex).name
	if (regex.search(generatedName)):
		generatedName = generatedName.left(-1)
	random = randf()
	if random * sellWind.allStrangers[targetIndex][5] * (1.0 - (severity / 100.0)) * (points * 0.01 + 0.2)> (severity/100.0):
		ledger.money += arguedVal
		ledger.addEntry(arguedVal, clock.theTime, sellWind.allStrangers[targetIndex][0], "Blackmail", blackmailIcon)
		if (dialogueLib.getEasterEggLine(generatedName) == "false"):
			terminalText.targetText = "> " + generatedName + ": " + dialogueLib.acceptLines.pick_random()
		else:
			terminalText.targetText = "> " + generatedName + ": " + dialogueLib.getEasterEggLine(generatedName)
		terminalText.targetText += "\n> System: Received $" + str(arguedVal)
	else:
		if (dialogueLib.getEasterEggLine(generatedName) == "false"):
			terminalText.targetText = "> " + generatedName + ": " + dialogueLib.rejectLines.pick_random()
		else:
			terminalText.targetText = "> " + generatedName + ": " + dialogueLib.getEasterEggLine(generatedName)
	terminalText.fillText()
	await get_tree().create_timer(1.5).timeout
	wrapItUp()

func wrapItUp():
	sellWind.removeStranger(sellWind.curSelPlace)
	sellWind.onButton()

func _on_lower_lower_severity() -> void:
	if (severity - 10) >= 0:
		severity -= 10

func _on_raise_raise_severity() -> void:
	if (severity + 10) <= 100:
		severity += 10
