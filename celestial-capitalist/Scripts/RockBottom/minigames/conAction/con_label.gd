extends RichTextLabel

@onready var backingText = get_node("../terminalTypeBacking")
@onready var reference = get_node("../ghostWriter")
@onready var timer = get_node("../typeTimer")

#way too much variables
var targetText = ""
var textDone = false
var active = false
var nextLetter = ""
var currentIndex = 0
var count = 0
var moving = false
var moved = false
var spaceWrongCount = 0
var wrongCount = 0
var movedOffset = 0
var movedOffset2 = 0

#variables for counting the score of the player
var score
var time
var allWrongCount = 0  #This one is for scoring points only
var allRightCount = 0

signal allDone(score)

var registeredSpaceOffenders = []
var ALLtheInputs = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", 
"A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M",
"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", 
"a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "colon",
"apostrophe", "z", "x", "c", "v", "b", "n", "m", ",", ".", "space", "!", "?"]

func _process(_delta):
	if active == true:
		if Input.is_action_just_pressed(nextLetter):
			if nextLetter == "space":
				text += " "
				reference.text += " "
			elif nextLetter == "colon":
				text += ":"
				reference.text += ":"
			elif nextLetter == "apostrophe":
				text += "'"
				reference.text += "'"
			else:
				text += nextLetter
				reference.text += nextLetter
			currentIndex += 1
			allRightCount += 1
			loadNext()
			checkProgress()
		elif Input.is_action_just_pressed("shift"):
			checkProgress()
		elif Input.is_action_just_pressed("backspace"):
			if len(text) > 7 and moved == false:
				if text[-1] == "]":
					currentIndex -= 1
					loadNext()
					if checkRegisteredSpaceOffenders(currentIndex):
						backingText.removeIncorrect(currentIndex)
						if spaceWrongCount > 0:
							spaceWrongCount -= 1
					text = text.left(-20)
					reference.text = reference.text.left(-1)
					wrongCount -= 1
				else:
					text = text.left(-1)
					reference.text = reference.text.left(-1)
					currentIndex -= 1
				loadNext()
				checkProgress()
			elif len(text) > 0 and moved == true:
				if text[-1] == "]":
					currentIndex -= 1
					loadNext()
					if checkRegisteredSpaceOffenders(currentIndex):
						backingText.removeIncorrect(currentIndex)
						if spaceWrongCount > 0:
							spaceWrongCount -= 1
					text = text.left(-20)
					reference.text = reference.text.left(-1)
					wrongCount -= 1
				else:
					text = text.left(-1)
					reference.text = reference.text.left(-1)
					currentIndex -= 1
				loadNext()
				checkProgress()
		elif checkForElse(Input):
			if nextLetter == "space":
				if spaceWrongCount < 15:
					for item in ALLtheInputs:
						if Input.is_action_just_pressed(item):
							if item == "apostrophe":
								text += "[color=red]'[/color]"
								reference.text += "'"
								backingText.addIncorrect("'", currentIndex - movedOffset2)
								currentIndex += 1
								break
							elif item == "colon":
								text += "[color=red]:[/color]"
								reference.text += ":"
								backingText.addIncorrect(":", currentIndex - movedOffset2)
								currentIndex += 1
								break
							else:
								text += "[color=red]" + str(item) +"[/color]"
								reference.text += str(item)
								backingText.addIncorrect(str(item), currentIndex - movedOffset2)
								currentIndex += 1
								break
					spaceWrongCount += 1
			else:
				if nextLetter == "apostrophe":
					text += "[color=red]'[/color]"
				elif nextLetter == "colon":
					text += "[color=red]:[/color]"
				else:
					text += "[color=red]" + str(nextLetter) +"[/color]"
				reference.text += nextLetter
				currentIndex += 1
				loadNext()
			wrongCount += 1
			allWrongCount += 1
			checkProgress()
	if text == targetText:
		textDone = true

func checkRegisteredSpaceOffenders(index):
	if registeredSpaceOffenders != []:
		for offender in registeredSpaceOffenders:
			if offender == index:
				return true

func checkForElse(theInput):
	for input in ALLtheInputs:
		if theInput.is_action_just_pressed(input) and theInput.is_action_just_pressed(input) != theInput.is_action_just_pressed(nextLetter):
			return true

func checkProgress():
	if reference.size.y > 180:
		if backingText.size.y > 181:
			moveDown()

func moveDown():
	moving = true
	count = 0
	var placeholder = len(text)
	for i in placeholder:
		text = text.erase(0, 1)
		if i <= placeholder - (wrongCount * 19):
			reference.text = reference.text.erase(0, 1)
			count += 1
			movedOffset2 += 1
		for offender in registeredSpaceOffenders:
			offender -= 1
		movedOffset += 1
	if wrongCount > 0:
		backingText.moveLine(count - 1)
		backingText.perfection = 0
	else:
		backingText.moveLine(count)
		backingText.perfection = 1
	backingText.movedYet = true

func initiate(dialogue):
	textDone = false
	nextLetter = ""
	currentIndex = 0
	count = 0
	moving = false
	moved = false
	wrongCount = 0
	spaceWrongCount = 0
	allWrongCount = 0
	allRightCount = 0
	movedOffset = 0
	movedOffset2 = 0
	textDone = false
	text = "> You: "
	reference.text = text
	currentIndex = 0
	targetText = dialogue
	backingText.initiate(dialogue)
	active = true
	loadNext()

func calcScore():
	var temp
	temp = ((allRightCount - allWrongCount) / (len(targetText) * 1.0)) + 0.5
	temp = (temp * 100) / time
	return temp

func loadNext():
	if len(targetText) > (currentIndex - spaceWrongCount):
		nextLetter = targetText[currentIndex - spaceWrongCount]
		if nextLetter == " ":
			nextLetter = "space"
		if nextLetter == ":":
			nextLetter = "colon"
		if nextLetter == "'":
			nextLetter = "apostrophe"
	else:
		time = timer.stopIt()
		score = calcScore()
		allDone.emit(score)
