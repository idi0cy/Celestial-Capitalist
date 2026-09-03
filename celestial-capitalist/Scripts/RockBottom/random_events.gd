class_name randomEvents
extends Resources

#region | normal starting variables (nodes, that stuff)
@onready var skills = get_node("../CenterWindows/Skills")
@onready var eventTimer = get_node("eventTimer")
@onready var popupScene = load("res://ButtonScenes/RockBottom/event_popup.tscn")
@onready var eventZone = get_node("eventZone")
@onready var ledger = get_node("../CenterWindows/Ledger")
@onready var clock = get_node("../digitalClock")
@onready var moneyIcon = load("res://assets/Sprites/RockBottom/ledgerWindow/donationIcon.png")
@onready var inventory = get_node("../CenterWindows/inventoryWind")
@onready var eventProg = get_node("eventBar/ProgressBar")
@onready var eventProgLabel = get_node("eventBar/Label")

var active = true
var waiting = true
var newPopup
var random
var invItem
#endregion

#region | Event setup
#underscores to differentiate from normal variables
#first value is weight of probability for the event
#second value is if the event is possible to occur yet
var robbed_eventChance = [20, true, "bad", 1]
var gifted_eventChance = [10, true, "good", 2]
var policeArrest_eventChance = [1500, false, "bad", 3]
var getFined_eventChance = [15, false, "bad", 4]
var scammer_eventChance = [10, true, "bad", 5]
var charitableGuy_eventChance = [8, true, "good", 6]
var giftedBurger_eventChance = [13, true, "good", 7]
var giftedWater_eventChance = [11, true, "good", 8]
var robbedItem_eventChance = [20, true, "bad", 9]

var allEvents = [robbed_eventChance, gifted_eventChance, policeArrest_eventChance,
getFined_eventChance, scammer_eventChance, charitableGuy_eventChance, giftedBurger_eventChance,
giftedWater_eventChance, robbedItem_eventChance]

var event_queue = []
#endregion

func refreshLuckValues(): #ensures probabilities of good and bad events are affected by luck skill
	for event in allEvents:
		if event[2] == "good":
			event[0] = event[0] * skills.luckMod
		else:
			event[0] = event[0] * (2 - skills.luckMod)

func pickEvent():
	var temp = 0 #this variable is used to add together the weighted probabilities
	#of all the events
	var temp2 = 0
	for event in allEvents:
		if event[1]:
			temp += event[0]
	temp2 = randi_range(1, temp)
	temp = 0
	for event in allEvents:
		if event[1]:
			temp += event[0]
			if temp >= temp2:
				return event

func _ready():
	refreshLuckValues()
	eventTimer.start()

func Round(number):
	return (floor(number * 100)) / 100.0

func _process(_delta):
	eventProg.value = (180 - floor(eventTimer.time_left)) / 180.0 * 100
	eventProgLabel.text = "Until Next Random Event: " + str(floor(eventTimer.time_left)) + " | (" + str(len(event_queue)) + ")"
	if active == true:
		if len(event_queue) > 0:
			newPopup = popupScene.instantiate()
			eventZone.add_child(newPopup)
			if event_queue[0][3] == 1:
				ledger.addEntry(Round(-(ledger.money * 0.15)), clock.theTime, "Unknown", "Robbed", moneyIcon)
				newPopup.initiate("You've been robbed. You lost $" + str(Round(ledger.money * 0.15)))
				ledger.money -= Round(ledger.money * 0.15)
			elif event_queue[0][3] == 2:
				ledger.addEntry(Round((ledger.money * 0.15)), clock.theTime, "Unknown", "Donated", moneyIcon)
				newPopup.initiate("You find some money on the floor, and pick up $" + str(Round(ledger.money * 0.15)))
				ledger.money += Round(ledger.money * 0.15)
			elif event_queue[0][3] == 3:
				inventory.currentInv = []
				newPopup.initiate("You've been arrested. Lose all your items.")
			elif event_queue[0][3] == 4:
				if ledger.money < 50:
					if ledger.money > 25:
						random = randi_range(25, floor(ledger.money))
					else:
						random = ledger.money
				else:
					random = randi_range(25,50)
				newPopup.initiate("You were fined $" + str(random))
				ledger.addEntry(-(random), clock.theTime, "The Law", "Fined", moneyIcon)
				ledger.money -= random
			elif event_queue[0][3] == 5:
				if ledger.money < 25:
					if ledger.money > 1:
						random = randi_range(1, floor(ledger.money))
					else:
						random = ledger.money
				else:
					random = randi_range(1,25)
				newPopup.initiate("You were swindled of $" + str(random))
				ledger.addEntry(-(random), clock.theTime, "Viktor", "Robbed", moneyIcon)
				ledger.money -= random
			elif event_queue[0][3] == 6:
				random = randi_range(5,25)
				newPopup.initiate("A generous patron gives you $" + str(random))
				ledger.addEntry(random, clock.theTime, "Unknown", "Donated", moneyIcon)
				ledger.money += random
			elif event_queue[0][3] == 7:
				newPopup.initiate("Someone gifts you a burger. You get a burger.")
				invItem = inventory.assembleItem(randi_range(75, 100), burger)
				inventory.addItem(invItem)
			elif event_queue[0][3] == 8:
				newPopup.initiate("Someone gifts you a water bottle.")
				invItem = inventory.assembleItem(randi_range(75, 100), waterBottle)
				inventory.addItem(invItem)
			elif event_queue[0][3] == 9:
				random = randi_range(0, len(inventory.currentInv) - 1)
				newPopup.initiate("A stranger robbed your " + inventory.currentInv[random][0][0])
				inventory.currentInv.pop_at(random)
			eventTimer.start()
			event_queue.pop_at(0)

func _on_event_timer_timeout() -> void:
	refreshLuckValues()
	var theEvent = pickEvent()
	event_queue.append(allEvents[theEvent[3] - 1])
	## THE BELOW CODE WAS SO STUPID
	
	#if theEvent[3] == 1:
		#event_queue.append(robbed_eventChance)
	#elif theEvent[3] == 2:
		#event_queue.append(gifted_eventChance)
	#elif theEvent[3] == 3:
		#event_queue.append(policeArrest_eventChance)
	#elif theEvent[3] == 4:
		#event_queue.append(getFined_eventChance)
	#elif theEvent[3] == 5:
		#event_queue.append(scammer_eventChance)
	#elif theEvent[3] == 6:
		#event_queue.append(charitableGuy_eventChance)
	#elif theEvent[3] == 7:
		#event_queue.append(giftedBurger_eventChance)
	#elif theEvent[3] == 8:
		#event_queue.append(giftedWater_eventChance)
