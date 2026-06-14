extends Node2D

@onready var progress = get_node("Progress")
@onready var directive = get_node("Directive")
@onready var dialogue = get_node("Dialogue")
@onready var confirmButton = get_node("Dialogue/Confirm/interactable")
@onready var done = get_node("Dialogue/Done")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWindow = get_node("../../../../sellWind")
@onready var ledger = get_node("../../../../Ledger")
@onready var clock = get_node("../../../../../digitalClock")

@onready var allStrangers = sellWindow.allStrangers

@onready var texture = load("res://assets/Sprites/RockBottom/inventoryIcons/hamburgInvIcon.png")

var begProgress = 0
var logosCount = 0
var ethosCount = 0
var pathosCount = 0
var baseVal = 5
var tries = 7
var targetStranger
var begVal = 0
var initiatingDone = false

func initiate(target):
	targetStranger = target
	initiatingDone = false
	begProgress = 1
	logosCount = 1
	ethosCount = 1
	pathosCount = 1
	tries = 8
	if confirmButton.pressed.is_connected(modifyProgress):
		confirmButton.pressed.disconnect(self.modifyProgress)
	confirmButton.pressed.connect(modifyProgress.bind("none"))
	terminalText.targetText = "> System: " + str(tries) + " more dialogue tries remaining."
	terminalText.fillText()
	show()

func modifyProgress(type):
	if initiatingDone == false:
		if tries > 0:
			if type == "logos":
				begProgress += (2.0/logosCount) * (allStrangers[targetStranger][4] + 0.5) * baseVal
				terminalText.targetText = "> You: If you donate to me, you'll be helping me become a functioning member of society AND you won't have to pay taxes."
			elif type == "pathos":
				begProgress += (2.0/pathosCount) * (allStrangers[targetStranger][3] + 0.5) * baseVal
				terminalText.targetText = "> You: Please, don't you want to help those in need?"
			elif type == "ethos":
				begProgress += (2.0/ethosCount) + (allStrangers[targetStranger][2] + 0.5) * baseVal
				terminalText.targetText = "> You: As an authority on homelessness, I can confirm it is very bad. Please help with the problem."
			else:
				terminalText.targetText = "> System: No dialogue choice selected. Please choose one."
			tries -= 1
			terminalText.targetText += "\n> System: " + str(tries) + " tries left."
		else:
			terminalText.targetText = "> System: No more tries remaining."
		terminalText.fillText()

func wrapItUp():
	if initiatingDone == false:
		if begProgress < 25:
			terminalText.targetText = "> " + str(allStrangers[targetStranger][0]) + ": No thanks... Please don't talk to me again."
			sellWindow.removeStranger(sellWindow.curSelPlace)
		else:
			var donationIcon = preload("res://assets/Sprites/RockBottom/ledgerWindow/donationIcon.png")
			begVal = 1 * ((begProgress * 0.01) + 0.25) * (allStrangers[targetStranger][1] + 0.5)
			begVal = (floor((begVal * 100))) / 100.0
			terminalText.targetText = "> " + str(allStrangers[targetStranger][0]) + ": Take $" + str(begVal) + "."
			ledger.money += begVal
			ledger.addEntry(begVal, clock.theTime, allStrangers[targetStranger][0], "Donated", donationIcon)
		print(begVal)
		terminalText.fillText()
		initiatingDone = true
		await get_tree().create_timer(2).timeout
		
		sellWindow.blankSlate()
		sellWindow.onButton()

func _on_logos_logos() -> void:
	if confirmButton.pressed.is_connected(modifyProgress):
		confirmButton.pressed.disconnect(self.modifyProgress)
	confirmButton.pressed.connect(modifyProgress.bind("logos"))

func _on_pathos_pathos() -> void:
	if confirmButton.pressed.is_connected(modifyProgress):
		confirmButton.pressed.disconnect(self.modifyProgress)
	confirmButton.pressed.connect(modifyProgress.bind("pathos"))

func _on_ethos_ethos() -> void:
	if confirmButton.pressed.is_connected(modifyProgress):
		confirmButton.pressed.disconnect(self.modifyProgress)
	confirmButton.pressed.connect(modifyProgress.bind("ethos"))

func _on_done_stop_begging() -> void:
	wrapItUp()
