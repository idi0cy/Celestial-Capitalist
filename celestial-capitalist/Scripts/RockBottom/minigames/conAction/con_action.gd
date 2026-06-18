extends Node2D

@onready var sellWind = get_node("../../../../sellWind")
@onready var clock = get_node("../../../../../digitalClock")
@onready var ledger = get_node("../../../../Ledger")
@onready var theGuy = get_node("../../theGuy")
@onready var conGuy = get_node("connedGuy")
@onready var conTermText = get_node("conTerminal/terminalType")
@onready var genericTerminalText = get_node("conTerminal/genericText")
@onready var conTerminal = get_node("conTerminal")
@onready var options = get_node("options")
@onready var buildTrust = get_node("options/buildTrust")
@onready var vulnerability = get_node("options/vulnerability")
@onready var findFlaw = get_node("options/findFlaw")
@onready var fearMonger = get_node("options/fearMonger")

@onready var allStrangers = sellWind.allStrangers

var targetIndex
var shadyGameText = [
	"Hey there. You ever hear about a game named pim? Well I'll tell you something, I'm willing to put BETS that I am the greatest player of this here game in the entire bloody city. It's simple, 20 stones, each player can take away 1-3 stones from the pile. Whoever takes the last rock, they win. You can go first, I'll have to go second. What do you say we go for a tenner?",
	"Three card monte! Ever want to test your luck.. or maybe your skill? If you can stop this card from leaving your eyes like my ex did, I'll be damned. Come on! Don't we all love a challenge? All you have to do is keep your eye on the prize. What do you say we go for five bucks, maybe ten if you're feeling lively?",
	"Wow, you look like you're looking for some good old fashioned analog fun, now aren't you? If you want to know if you're favoured by a higher power, I've got something for you. A simple game of luck, perfect 50/50. You choose a one dollar coin, and I'll flip it. Heads I win, tails you lose, easy rules, what do you say we do it?"
]
var trustProgress = 0
var flawFound = false
var query

func initiate(target):
	flawFound = false
	trustProgress = 0
	targetIndex = target
	conGuy.texture = theGuy.texture
	conTermText.hide()
	theGuy.hide()
	options.hide()
	conTerminal.show()
	genericTerminalText.targetText = "> System: Choose dialogue options, and type them out as quick as possible to make progress."
	genericTerminalText.show()
	show()
	genericTerminalText.fillText()
	await get_tree().create_timer(3).timeout
	
	doOptions()

func doOptions():
	genericTerminalText.hide()
	options.show()
	buildTrust.hide()
	vulnerability.hide()
	findFlaw.hide()
	fearMonger.hide()
	if trustProgress < 25:
		buildTrust.show()
	elif trustProgress <= 65:
		buildTrust.show()
		vulnerability.show()
	elif trustProgress <= 100:
		buildTrust.show()
		vulnerability.show()
		findFlaw.show()
	if flawFound == true:
		fearMonger.show()

func startTyping(type):
	pass
	if type == "fake value":
		pass

func _on_magic_magic() -> void:
	startTyping("magic")

func _on_fake_value_fake_value() -> void:
	startTyping("fake value")

func _on_oppurtunity_oppurtunity() -> void:
	startTyping("oppurtunity")

func _on_shady_game_shady_game() -> void:
	startTyping("shady game")
