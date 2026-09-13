extends Node2D

@onready var tutorialText = $tutorialText
@onready var nameWrite = $name
@onready var startButton = $startFromTutorial
@onready var clickPrompt = $clickPrompt

var tutorialStage:int = 0
var tutorialEngaged:bool = false
var typingName:bool = false
var lastScreen:bool = false
var tween
var check = 0

var lines = {
	0: "Welcome to Celestial Capitalist.",
	1: "Let's cut to the chase.",
	2: "You're homeless and alone, and almost definitely single.",
	3: "You have practically nothing to your name. Actually, I'm not even going to give you one. That's just how impoverished you are. ",
	4: "Here, you can do that yourself.",
	5: "",
	6: "In order to survive, you are constantly forced to scavenge for goods, and sell scraps to pinch pennies. You are starving and cold on this street and nothing feels good anymore.",
	7: "If you want to get out of this hole, you're gonna have to scrounge up bigger and bigger sums. Five hundred dollars is only the beginning - but meet your quota over and over, and you just might become something far beyond what you could imagine now.",
	8: "The only good you own is yourself. You bought low, so now you sell high.",
	9: ""
}

func _ready():
	nameWrite.hide()

func _on_tutorial() -> void:
	clickPrompt.show()
	tutorialText.targetText = "Welcome to Celestial Capitalist."
	tutorialText.fillText()
	tutorialEngaged = true
func _process(_delta: float) -> void:
	if tutorialStage != check && tutorialStage < 10:
		tutorialText.targetText = lines.get(tutorialStage)
		tutorialText.fillText()
		if tutorialStage == 5:
			typingName = true
			nameWrite.show()
		if tutorialStage == 9:
			lastScreen = true
			clickPrompt.hide()
			await get_tree().create_timer(1).timeout
			startButton.show()
			if tween:
				tween.kill()
			tween = create_tween()
			tween.tween_property(startButton, "modulate:a", 1, 1.5)
	check = tutorialStage

func _input(event):
	if event.is_action_pressed("click") && tutorialEngaged && !typingName && !lastScreen:
		PleaseSendHelp.buttonGotPressed.emit()
		if tutorialStage <= 8:
			tutorialStage += 1

func _on_name_text_submitted(new_text: String) -> void:
	if new_text != "":
		PleaseSendHelp.saveName = new_text
		nameWrite.hide()
		tutorialStage = 6
		typingName = false
	else:
		nameWrite.placeholder_text = "Cannot enter nothing."
