extends Node2D

@onready var ledger = get_node("../../../../Ledger")
@onready var clock = get_node("../../../../../digitalClock")

@onready var sellWind = get_node("../../../../sellWind")
@onready var options = get_node("options")
@onready var theGuy = get_node("../../theGuy")
@onready var stealthGame = get_node("stealthGame")
@onready var strengthGame = get_node("strengthGame")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var terminal = get_node("../../Terminal")

@onready var texture = load("res://assets/Sprites/RockBottom/ledgerWindow/donationIcon.png")

var target
var consequenceCheck

func initiate(targetIndex):
	target = targetIndex
	stealthGame.hide()
	strengthGame.hide()
	
	options.show()
	theGuy.show()
	show()

func _on_strength_option_use_strength() -> void:
	terminal.hide()
	options.hide()
	theGuy.hide()
	
	strengthGame.show()
	strengthGame.initiate(sellWind.allStrangers[target][7] + 0.5)

func _on_stealth_option_use_stealth() -> void:
	terminal.hide()
	stealthGame.show()
	
	options.hide()
	theGuy.hide()
	stealthGame.initiate(target, sellWind.allStrangers[target][6] + 0.5)

func _on_stealth_game_finished(goodOrBad: Variant) -> void:
	pass # Replace with function body.
	if goodOrBad == "success":
		if stealthGame.perfection == true:
			ledger.money += 10 * sellWind.allStrangers[target][1]
			ledger.addEntry(10 * sellWind.allStrangers[target][1], clock.theTime, sellWind.allStrangers[target][0], "Stolen", texture)
			terminalText.targetText = "> System: Successfully stole $" + str(10 * sellWind.allStrangers[target][1]) + " without being detected."
		else:
			consequenceCheck = randf()
			if consequenceCheck < 15:
				ledger.money += 10 * sellWind.allStrangers[target][1]
				ledger.addEntry(10 * sellWind.allStrangers[target][1], clock.theTime, sellWind.allStrangers[target][0], "Stolen", texture)
				terminalText.targetText = "> System: Successfully stole $" + str(10 * sellWind.allStrangers[target][1]) + ". The police have been called on you."
				sellWind.removeStranger(sellWind.curSelPlace)
			else:
				ledger.money += 10 * sellWind.allStrangers[target][1]
				ledger.addEntry(10 * sellWind.allStrangers[target][1], clock.theTime, sellWind.allStrangers[target][0], "Stolen", texture)
				terminalText.targetText = "> System: Successfully stole $" + str(10 * sellWind.allStrangers[target][1]) + " without being detected."
	elif goodOrBad == "fail":
		consequenceCheck = randf()
		if consequenceCheck < 25:
			terminalText.targetText = "> System: You failed to steal from " + str(sellWind.allStrangers[target][0]) + ". The police have been called."
			# Please remember to have actual consequences for bottom
			sellWind.removeStranger(sellWind.curSelPlace)
		else:
			terminalText.targetText = "> System: You failed to steal from " + str(sellWind.allStrangers[target][0]) + "."
	stealthGame.hide()
	terminal.show()
	theGuy.show()
	terminalText.fillText()
	await get_tree().create_timer(4).timeout
	
	sellWind.blankSlate()
	sellWind.onButton()

func _on_strength_game_all_done(result: Variant) -> void:
	if result == "success":
		ledger.money += 10 * sellWind.allStrangers[target][1]
		ledger.addEntry(10 * sellWind.allStrangers[target][1], clock.theTime, sellWind.allStrangers[target][0], "Stolen", texture)
		terminalText.targetText = "> System: Successfully stole $" + str(10 * sellWind.allStrangers[target][1]) + "."
	else:
		terminalText.targetText = "> System: You lost the fight."
	
	terminalText.targetText += " The police have been called on you."
	terminalText.fillText()
	sellWind.removeStranger(sellWind.curSelPlace)
	strengthGame.hide()
	terminal.show()
	theGuy.show()
	await get_tree().create_timer(4).timeout
	
	sellWind.blankSlate()
	sellWind.onButton()
