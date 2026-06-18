extends RichTextLabel

var targetText = ""
var textDone = false
var active = false
var nextLetter = ""
var currentIndex = 0

func _process(_delta):
	if active == true:
		if Input.is_action_just_pressed(nextLetter):
			pass
		elif Input.is_action_just_pressed("shift"):
			#intentional blank thing to not say they got it wrong if they're just holding shift
			pass
		else:
			#insert code for failure here
			pass
	if text == targetText:
		textDone = true

func initiate(dialogue):
	currentIndex = 0
	targetText = dialogue
	active = true

func loadNext():
	nextLetter = targetText[currentIndex]
	if nextLetter == " ":
		nextLetter == "space"
	if nextLetter == ":":
		nextLetter = "colon"
