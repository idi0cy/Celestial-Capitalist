extends Label

@onready var reference = get_node("../ghostWriter")
@onready var terminalOther = get_node("../terminalType")

var targetText = ""
var currentText = ""
var textDone = false
var movedYet = false
var checking = false
var moving = false
var perfection = 0

var listOfAdded = []

func _process(_delta):
	currentText = text

func initiate(theText):
	perfection = 0
	movedYet = false
	checking = false
	moving = false
	targetText = theText
	fillText()

func fillText():
	if movedYet == false:
		text = "> You: "
	text += targetText

func addIncorrect(letter, index):
	if terminalOther.movedOffset2 == 0:
		text = text.insert((index + 7 - perfection), letter)
	else:
		text = text.insert((index + 8 - perfection), letter)
	terminalOther.registeredSpaceOffenders.append((index + terminalOther.movedOffset2))

func removeIncorrect(index):
	if terminalOther.movedOffset2 == 0:
		text = text.erase((index - terminalOther.movedOffset2 + 7 - perfection), 1)
	else:
		text = text.erase((index - terminalOther.movedOffset2 + 8 - perfection), 1)
	for offender in terminalOther.registeredSpaceOffenders:
		if offender == index:
			terminalOther.registeredSpaceOffenders.erase(offender)

func checkNewMargins():
	checking = true
	while checking:
		if self.size.y > 181:
			text = text.left(text.length() - 1)
		else:
			checking = false
			break

func moveLine(count):
	text = text.erase(0, count)
	terminalOther.registeredSpaceOffenders = []
	terminalOther.wrongCount = 0
