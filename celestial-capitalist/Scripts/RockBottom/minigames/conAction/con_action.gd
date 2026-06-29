extends Node2D

@onready var dialogue = get_node("../../minigameWindows")
@onready var sellWind = get_node("../../../../sellWind")
@onready var clock = get_node("../../../../../digitalClock")
@onready var ledger = get_node("../../../../Ledger")
@onready var theGuy = get_node("../../theGuy")
@onready var conGuy = get_node("connedGuy")
@onready var typeGame = get_node("conTerminal/typeGame")
@onready var conTermText = get_node("conTerminal/typeGame/terminalType")
@onready var genericTerminalText = get_node("../../Terminal/termText")
@onready var genericTerminal = get_node("../../Terminal")
@onready var conTerminal = get_node("conTerminal")
@onready var options = get_node("options")
@onready var shadyGame = get_node("options/shadyGame")
@onready var oppurtunity = get_node("options/oppurtunity")
@onready var fakeValue = get_node("options/fakeValue")
@onready var magic = get_node("options/magic")
@onready var typeTimer = get_node("conTerminal/typeGame/typeTimer")
@onready var riskMarker = get_node("Severity/spectrumOfBall/marker")
@onready var theRiskStuff = get_node("Severity")

@onready var texture = load("res://assets/Sprites/RockBottom/ledgerWindow/donationIcon.png")

var targetIndex

#DO NOT MAKE THESE DIALOGUE OPTIONS TOO LONG, BECAUSE AFTER ONE SET OF LOADING THE TEXT THAT IS NOT
#VISIBLE< THINGS START BREAKING

#SOME CHARACTERS ARE NOT INCLUDED IN THE LIST OF INPUTS, AND WILL NOT WORK

var shadyGameText = [
	"Hey there. You ever hear about a game named pim? Well I'll tell you something, I'm willing to put BETS that I am the greatest player of this here game in the entire bloody city. It's simple, twenty stones, each player can take away one to three stones from the pile. Whoever takes the last rock, they win. You can go first, I'll have to go second. What do you say we go for a tenner?",
	"Three card monte! Ever want to test your luck.. or maybe your skill? If you can stop this card from leaving your eyes like my ex did, I'll be damned. Come on! Don't we all love a challenge? All you have to do is keep your eye on the prize. What do you say we go for five bucks, maybe ten if you're feeling lively?",
	"Wow, you look like you're looking for some good old fashioned analog fun, now aren't you? If you want to know if you're favoured by a higher power, I've got something for you. A simple game of luck, perfect fifty fifty. You choose a one dollar coin, and I'll flip it. Heads I win, tails you lose, easy rules, I'll even let you flip the coin, what do you say we do it?",
]
var magicText = [
	"Halt! Stranger, it would be a crime of me not to inform you, however I must admit that I am detecting a foreign prescence within your aura. Have you been having any bad luck lately? Friends who've abandoned you? Less mobility in your job? I know the source of your woes, and it's a curse placed to damn you to a life without success. I can exorcise it, but I'm not exactly fluid, right now, so I'll need some financial compensation.",
	"Hey there. Do you ever wish to know things that you maybe shouldn't? Any supernatural wonders you've wanted to experience? Well I can quench that thirst right here for only a couple bucks. Any person, any time. Dead, or alive. I'll be a medium for their brief return to talk with you. It's not a joke. If there's anyone you need to talk to, the offer is right here, and for a limited time only. I'm very fluid with my living situation.",
	"You look like you have desire. One strong enough to warrant... divine intervention. Any will of yours may very well be imparted by the gods themselves on this very day. I'm able to give blessings, place cursings, on anyone, it just can't be yourself. Even a ruler has rules. What do you say to this deal? Only takes your time and a bit of money."
]
var oppurtunityText = [
	"Hey there, you seem like you're ready for some action, financial, action. Now I've been told to keep pretty quiet about this, but I think I can make exceptions for capable individuals. Me and my associates are starting an investment firm, and we're looking for early members. Any amount will do fine, and I promise you the returns will be great! I'll take cash now, then contact me at Ice Station Zebra Associates' office for more.",
	"It's your lucky day, because it appears that you've just won an exclusive draw to test a cutting edge new product made by EM sports! I'm here representing the company, and we're scouting individuals who we believe would make for good game testers of the new game, Celestial Capitalist. You've been chosen as one of the contestents, and have the chance to preorder the game with me here now.",
	"You there! Yes, you! You have been selected to participate in a special TV show called lucky bastards, where you and other contestants participate in various games of chance and skill, such as poker, to win a huge cash prize, and rewards for those who do good. The oppurtunity is here now, but we'll have to take a small payment to authorize yourself into the show. If you're interested, agents such as myself can accept cash now."
]
var fakeValueText = [
	"Hey dude, I'm in a bit of a tough situation right now, could I interest you in something that would be worth your time? My family isn't the most well off, but we've been passing down this for generations by now. It's a coin, minted in the rare year of ninteen eighty four. These are one of a kind, and they are going to be worth a lot more than what I'm willing to sell them to you for.",
	"Do you happen to know a good appraiser? Because they will be salivating after seeing what I have in hand right now. This is a rare stone that looks unimportant, but is actually one of the rarest in the world. It's an impure version of diamond, but has the same chemical makeup, and it's seen much less often. Trust me, even Rick Harrison would buy it at the price I'm offering, and that guy would only offer five cents to buy a nuclear bomb.",
	"I've got some insider info on which stocks are going to go up in the upcoming weeks. My parents are actually politicians, and they know what's going on in the markets. I'm willing to offer up some of this priceless information for very cheap, so you'd best get ready to invest, and brace yourself for the best deal of your life."
]

var strangerResponse
var query
var random
var playerScore = 0
var risk = 50
var stakes = 0.0
var random2
var baseStakes
var successModifier

func initiate(target):
	risk = 50
	riskMarker.update()
	targetIndex = target
	conGuy.texture = theGuy.texture
	conGuy.show()
	typeGame.hide()
	theGuy.hide()
	options.hide()
	theRiskStuff.hide()
	conTerminal.show()
	genericTerminalText.targetText = "> System: Choose dialogue options, and type them out as quick as possible to make progress."
	genericTerminal.show()
	genericTerminalText.show()
	show()
	genericTerminalText.fillText()
	#await get_tree().create_timer(3).timeout
	
	doOptions()

func doOptions():
	#genericTerminalText.hide()
	options.show()

func startTyping(type):
	random = randi_range(0,2) #make this how much text options there are for the things
	if type == "fake value":
		query = fakeValueText[random]
		successModifier = sellWind.allStrangers[targetIndex][4] + 0.5
		baseStakes = 5.0
	elif type == "magic":
		query = magicText[random]
		successModifier = sellWind.allStrangers[targetIndex][5] + 0.5
		baseStakes = 10.0
	elif type  == "oppurtunity":
		query = oppurtunityText[random]
		successModifier = sellWind.allStrangers[targetIndex][4] + 0.5
		baseStakes = 7.5
	elif type == "shady game":
		query = shadyGameText[random]
		successModifier = sellWind.allStrangers[targetIndex][8] + 0.5
		baseStakes = 5
	#hide everything for the typing game
	genericTerminal.hide()
	conGuy.show()
	options.hide()
	typeGame.show()
	conTerminal.show()
	conTermText.initiate(query)
	typeTimer.initiate()

func _on_magic_magic() -> void:
	startTyping("magic")
	strangerResponse = dialogue.magicScammedLines.pick_random()

func _on_fake_value_fake_value() -> void:
	startTyping("fake value")
	strangerResponse = dialogue.fakeValueScammedLines.pick_random()

func _on_oppurtunity_oppurtunity() -> void:
	startTyping("oppurtunity")
	strangerResponse = dialogue.oppurtunityScammedLines.pick_random()

func _on_shady_game_shady_game() -> void:
	startTyping("shady game")
	strangerResponse = dialogue.shadyGameScammedLines.pick_random()

func _on_terminal_type_all_done(score: Variant) -> void:
	playerScore = score
	
	#initiate the next part
	conTerminal.hide()
	genericTerminal.show()
	theRiskStuff.show()

func _on_less_risk_lower_risk() -> void:
	if risk > 0:
		risk -= 10
	riskMarker.update()

func _on_more_risk_more_risk() -> void:
	if risk < 100:
		risk += 10
	riskMarker.update()

func _on_goldilocks_settle_risk() -> void:
	pass # Replace with function body.
	theRiskStuff.hide()
	conTerminal.hide()
	print(playerScore)
	random2 = randf()
	stakes = ((risk * 0.01) + 0.5) * baseStakes
	
	if (random2 * 100) * playerScore * successModifier > stakes * 12:
		ledger.money += stakes
		ledger.addEntry(stakes, clock.theTime, sellWind.allStrangers[targetIndex][0], "Scammed", texture)
		genericTerminalText.targetText = "> " + sellWind.allStrangers[targetIndex][0] + ": " + strangerResponse
		genericTerminalText.targetText += "\n> System: Received $" + str(stakes)
	else:
		genericTerminalText.targetText = "> " + sellWind.allStrangers[targetIndex][0] + ": " + dialogue.conFailsDialogue.pick_random()
	sellWind.removeStranger(sellWind.curSelPlace)
	
	conGuy.hide()
	genericTerminal.show()
	theGuy.show()
	genericTerminalText.fillText()
	await get_tree().create_timer(5).timeout
	
	sellWind.blankSlate()
	sellWind.onButton()
