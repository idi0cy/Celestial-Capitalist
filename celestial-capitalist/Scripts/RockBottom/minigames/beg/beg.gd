class_name Beg
extends Resources
## Controls the beg minigame.

#region nodes
@onready var progress = get_node("Progress")
@onready var directive = get_node("Directive")
@onready var dialogue = get_node("Dialogue")
@onready var confirmButton = get_node("Dialogue/Confirm/interactable")
@onready var done = get_node("Dialogue/Done")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWindow = get_node("../../../../sellWind")
@onready var ledger = get_node("../../../../Ledger")
@onready var clock = get_node("../../../../../digitalClock")
@onready var peopleList = get_node("../../../../sellWind/PickTarget/PeopleList")
@onready var skill = get_node("../../../../Skills")
#endregion

#region variables
## The base progress value awarded for pressing the button, pre modifier.
const baseVal = 5

## The index of the current stranger within the [StrangerList]
var storedStrangerIndex : int
## The overall progress of the game.
var begProgress = 1
## The amount of tries remaining
var tries = 8
## The name/id of the current stranger, for use in [member SellWindow.allStrangers]
var targetStranger
## Checks whether a game is in progress
var initiatingDone = false
var finishing = false
var random #skill point determiner
var logosCount = 0
var pathosCount = 0
var ethosCount = 0
#endregion

#region game
## Start the game with [member targetStranger].
func initiate(targetID):
	finishing = false
	targetStranger = targetID
	initiatingDone = false
	if confirmButton.pressed.is_connected(modifyProgress):
		confirmButton.pressed.disconnect(self.modifyProgress)
	confirmButton.pressed.connect(modifyProgress.bind("none"))
	terminalText.targetText = "> System: " + str(tries) + " more dialogue tries remaining."
	terminalText.fillText()
	show()

## Called when the confirm button is pressed. Increments [member begProgress] based on [member baseVal], the stranger's properties, and the option chosen.
func modifyProgress(type):
	if initiatingDone == false:
		if tries > 0:
			# Calculates [member begProgress] with diminishing returns per every time the same button is pressed. Buttons more effective on the current stranger will suffer less diminishing returns.
			if type == "logos":
				logosCount += 1
				begProgress += (sellWindow.allStrangers[targetStranger][4] + 0.5) * ((sellWindow.allStrangers[targetStranger][4]*10)/logosCount)
				terminalText.targetText = "> You: " + logosLines.pick_random()
			elif type == "pathos":
				pathosCount += 1
				begProgress += (sellWindow.allStrangers[targetStranger][3] + 0.5) * ((sellWindow.allStrangers[targetStranger][3]*10)/pathosCount)
				terminalText.targetText = "> You: " + pathosLines.pick_random()
			elif type == "ethos":
				ethosCount += 1
				begProgress += (sellWindow.allStrangers[targetStranger][2] + 0.5) * ((sellWindow.allStrangers[targetStranger][2]*10)/ethosCount)
				terminalText.targetText = "> You: " + ethosLines.pick_random()
			else:
				terminalText.targetText = "> System: No dialogue choice selected. Please choose one."
			tries -= 1
			terminalText.targetText += "\n> System: " + str(tries) + " tries left."
		else:
			terminalText.targetText = "> System: No more tries remaining."
		terminalText.fillText()

## Called when the done button is pressed. Finishes the game. [br]
## [br]
## 1. Gets the current stranger's name.
## 2. Checks if [member begProgress] is over 25. If not, game fails and outputs dialogue. If yes, add to ledger and output dialogue.
## 3. Waits and closes window.
func _on_done_stop_begging() -> void:
	if initiatingDone == false:
		finishing = true
		begProgress = begProgress * skill.charismaMod
		#1.
		## The regex engine.
		var regex = RegEx.new()
		regex.compile("\\d")
		## The current stranger's name.
		var generatedName = peopleList.get_child(storedStrangerIndex).name
		if (regex.search(generatedName)):
			generatedName = generatedName.left(-1)
		#2.
		if begProgress < 25:
			if (getEasterEggLine(generatedName) == "false"):
				terminalText.targetText = "> " + generatedName + ": " + rejectLines.pick_random()
			else:
				terminalText.targetText = "> " + generatedName + ": " + getEasterEggLine(generatedName)
			sellWindow.removeStranger(sellWindow.currentStrangerIndex)
		else:
			## The amount of money begged.
			var begVal = 1 * ((begProgress * 0.01) + 0.25) * (sellWindow.allStrangers[targetStranger][1] + 0.5)
			begVal = (floor(begVal * 100)) / 100.0
			if (getEasterEggLine(generatedName) == "false"):
				terminalText.targetText = "> " + generatedName + ": " + acceptLines.pick_random()
			else:
				terminalText.targetText = "> " + generatedName + ": " + getEasterEggLine(generatedName)
			terminalText.targetText += "\n> System: Received $" + str(begVal)
			ledger.addEntry(begVal, clock.theTime, generatedName, "Donated", donationIcon)
		
		#determine if skill point is gained
		random = randf()
		if random >= 0.91:
			skill.points += 1
		
		terminalText.fillText()
		initiatingDone = true
		
		#3.
		await get_tree().create_timer(4).timeout
		sellWindow.reset()
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
#endregion game
