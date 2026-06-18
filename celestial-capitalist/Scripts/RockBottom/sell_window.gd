extends Node2D

#Options so far are as follows
#Beg, Sales Pitch, Fake Injury, Steal, Con

#general
@onready var clock = get_node("../../digitalClock")
@onready var personNameLabel = get_node("PickTarget/personName")
@onready var approachButton = get_node("PickTarget/approachButton/Button")
@onready var approachButtonGeneral = get_node("PickTarget/approachButton")
@onready var PeopleList = get_node("PickTarget/PeopleList")
@onready var directiveFirst = get_node("PickTarget/Directive")
@onready var refreshExplanation = get_node("PickTarget/explanation")
@onready var refreshTimer = get_node("PickTarget/strangerRefresh")

#post approach
@onready var postApproach = get_node("postApproach")
@onready var actions = get_node("postApproach/Actions")
@onready var strangerSprite = get_node("postApproach/theGuy")
@onready var confirmAction = get_node("postApproach/Actions/takeAction")
@onready var terminal = get_node("postApproach/Terminal")
@onready var terminalText = get_node("postApproach/Terminal/termText")

#minigame HAGGLE
@onready var minigameWindows = get_node("postApproach/minigameWindows")
@onready var pickToSell = get_node("postApproach/minigameWindows/pickToSell")
@onready var haggle = get_node("postApproach/minigameWindows/Haggle")
@onready var haggleDialogue = get_node("postApproach/minigameWindows/Haggle/dialogue")
@onready var hagglePricing = get_node("postApproach/minigameWindows/Haggle/pricing")
@onready var haggleBar = get_node("postApproach/minigameWindows/Haggle/haggleBar")
@onready var haggleDirective = get_node("postApproach/minigameWindows/Haggle/Directive")
@onready var aimTrainZone = get_node("postApproach/minigameWindows/Haggle/aimTrainZone")
@onready var spectrumOfBall = get_node("postApproach/minigameWindows/Haggle/pricing/spectrumOfBall")

#minigame BEG
@onready var begWindow = get_node("postApproach/minigameWindows/Beg")

#minigame FAKE INJURY
@onready var fakeInjury = get_node("postApproach/minigameWindows/FakeInjury")
@onready var fakeInjurySeverity = get_node("postApproach/minigameWindows/FakeInjury/severityPick")
@onready var fakeInjuryMinigame = get_node("postApproach/minigameWindows/FakeInjury/minigamePart")

#stands for 'person sprite'
@onready var psPlaceholder = load("res://assets/Sprites/RockBottom/streetRoamers/personPlaceholder.png")
@onready var personButtonScript = load("res://Scripts/RockBottom/stranger_button.gd")

var sellWindowOpen = false
var count
var count2
var random
var random2
var temporaryList = []
var alreadyFound = []
var placeHolder
var needToFind
var strangerButton
var initiatingAction = false
var targetIndex
var curSelPlace

#okay well this is going to be an absolute horror.

#try to have more success rate the higher the values are for uniformity
#index 0 is name of person, index 1 is wealth, index 2 is approachability
#3 empathy (beg effectiveness), 4 persuadable (sales), 5 guillable (fake injury)
#6 unassuming (steal stealth), 7 weakness (steal strength)
#8 risk taking (con) 0.4
const richAndOld = ["Rich Old Person", 0.9, 0.4, 0.5, 0.5, 0.6, 0.5, 0.8, 0.2]
const anotherHomeless = ["Homeless", 0.1, 0.8, 0.2, 0.1, 0.1, 0.7, 0.5, 0.7]
const middleAgedAverage = ["Average Middle Aged", 0.6, 0.7, 0.7, 0.6, 0.5, 0.3, 0.2, 0.5]
#For the kid, only display "kid", and have them be harder to predict
const niceKid = ["Child", 0.2, 0.6, 0.9, 0.8, 0.0, 0.9, 0.5, 1, 0.8]
const skepticKid = ["Child 2", 0.3, 0.4, 0.2, 0.2, 0.0, 0.7, 1, 0.2]
const charityWorker = ["Charity Worker", 0.5, 1, 0.9, 0.5, 0.4, 0.3, 0.4, 0.2]

const allStrangers = [richAndOld, anotherHomeless, middleAgedAverage, niceKid, skepticKid, charityWorker]

func _ready():
	blankSlate()
	for item in PeopleList.get_children():
		PeopleList.remove_child(item)
		item.queue_free()
	genStrangers()

func _process(_delta):
	if sellWindowOpen == false:
		self.hide()
	else:
		self.show()

func _on_sell_button_open_sell_wind() -> void:
	onButton()

func onButton():
	initiatingAction = false
	haggleDialogue.hide()
	postApproach.hide()
	terminalText.targetText = ""
	terminalText.fillText()
	blankSlate()
	sellWindowOpen = not sellWindowOpen
	if sellWindowOpen == true:
		PeopleList.peopleListHidden = false
		personNameLabel.text = ""
		personNameLabel.show()
		directiveFirst.targetText = "Pedestrians Identified"
		directiveFirst.fillText()
		refreshExplanation.targetText = "Until new strangers"
		refreshExplanation.fillText()
		directiveFirst.show()
		#genStrangers()

func genStrangers():
	for item in PeopleList.get_children():
		PeopleList.remove_child(item)
		item.queue_free()
	
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
	approachButtonGeneral.hide()
	personNameLabel.targetText = ""
	personNameLabel.fillText()
	
	if clock.theTime >= 1320 or clock.theTime <= 300:
		random = randi_range(0,1)
	elif clock.theTime > 300 and clock.theTime <= 420:
		random = randi_range(1,2)
	elif clock.theTime > 420 and clock.theTime <= 510:
		random = randi_range(2,3)
	elif clock.theTime > 510 and clock.theTime <= 600:
		random = 4
	elif clock.theTime > 600 and clock.theTime <= 960:
		random = randi_range(2,3)
	elif clock.theTime > 960 and clock.theTime <=1080:
		random = 4
	else:
		random = randi_range(3,4)

	temporaryList = []
	for item in allStrangers:
		temporaryList.append(item)
	
	alreadyFound = []
	count2 = 0
	for i in random:
		random2 = randi_range(0, (len(temporaryList) - 1))
		while alreadyFound.has(random2):
			random2 = randi_range(0, (len(temporaryList) - 1))
		strangerButton = TextureButton.new()
		strangerButton.texture_normal = psPlaceholder
		strangerButton.name = str(allStrangers[random2][0])
		strangerButton.set_script(personButtonScript)
		strangerButton.baseInfo = allStrangers[random2]
		strangerButton.index = count2
		strangerButton.pressed.connect(identifyTarget.bind(random2, count2))
		PeopleList.add_child(strangerButton)
		alreadyFound.append(random2)
		
		count2 += 1

func removeStranger(index):
	count = 0
	for obj in PeopleList.get_children():
		if count == index:
			PeopleList.remove_child(obj)
			obj.queue_free()
		count += 1

func blankSlate():
	#normal sell window
	curSelPlace = "None"
	refreshExplanation.targetText = ""
	refreshExplanation.fillText()
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
	directiveFirst.show()
	personNameLabel.show()
	personNameLabel.text = ""
	terminalText.targetText = ""
	terminalText.fillText()
	terminal.hide()
	approachButtonGeneral.hide()
	postApproach.hide()
	$PickTarget.show()
	
	#haggle window
	haggle.hide()
	haggleDialogue.hide()
	hagglePricing.hide()
	aimTrainZone.hide()
	spectrumOfBall.hide()
	pickToSell.closeIcons()
	haggleBar.hide()
	haggleDirective.hide()
	
	#beg window
	begWindow.hide()
	
	#fake injury window
	fakeInjury.hide()
	fakeInjurySeverity.hide()
	fakeInjuryMinigame.hide()
	
	initiatingAction = false

func identifyTarget(index, place):
	personNameLabel.targetText = allStrangers[index][0]
	personNameLabel.fillText()
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
	approachButton.pressed.connect(approachStranger.bind(index, place))
	approachButtonGeneral.show()

func approachStranger(index, place):
	confirmAction.personIndex = index
	curSelPlace = place
	directiveFirst.hide()
	$PickTarget/personName.hide()
	approachButtonGeneral.hide()
	postApproach.show()
	$postApproach/Actions.show()
	$postApproach/theGuy.show()
	$postApproach/Terminal.show()
	$postApproach/minigameWindows.hide()
	PeopleList.peopleListHidden = true
	
func _on_take_action_confirm_action(theAction, target) -> void:
	if theAction == "No Action":
		noAction(target)
	elif theAction == "Sales Pitch":
		salesPitch(target)
	elif theAction == "Beg":
		begAction(target)
	elif theAction == "Fake Injury":
		fakeInjuryAction(target)
	elif theAction == "Steal":
		steal(target)
	elif theAction == "Con":
		conTarget(target)
	else:
		noAction(target)

func noAction(target):
	if initiatingAction == false:
		#print(target)
		terminalText.targetText = "> System: No action taken. Please select an action before taking it."
		terminalText.fillText()

func salesPitch(target):
	if initiatingAction == false:
		initiatingAction = true
		terminalText.targetText = "> System: Trying to impress customers..."
		terminalText.fillText()
		#maybe play cool sound effect while waiting
		await get_tree().create_timer(2).timeout
		minigameWindows.show()
		pickToSell.openPickToSell()
		haggle.target = target

func begAction(target):
	if initiatingAction == false:
		initiatingAction = true
		terminalText.targetText = "> System: Preparing to cry..."
		terminalText.fillText()
		await get_tree().create_timer(2).timeout
		onStartBeg()
		begWindow.initiate(target)
		minigameWindows.show()

func fakeInjuryAction(target):
	if initiatingAction == false:
		initiatingAction = true
		terminalText.targetText = "> System: Weakening ankles..."
		terminalText.fillText()
		await get_tree().create_timer(2).timeout
		#This better work as a substitute
		onStartBeg()
		fakeInjury.initiate(target)
		minigameWindows.show()

func steal(target):
	if initiatingAction == false:
		initiatingAction = true
		#print(target)
		terminalText.targetText = "> System: Eyeing enemy pockets..."
		terminalText.fillText()

func conTarget(target):
	if initiatingAction == false:
		initiatingAction = true
		#print(target)
		terminalText.targetText = "> System: Ideating new scams..."
		terminalText.fillText()

func _on_confirm_confirm_selection() -> void:
	actions.hide()
	strangerSprite.hide()
	terminalText.targetText = "System: Use above strategies to convince the target. Each strategy has different risk factor to it, which determines both difficulty and reward."
	terminalText.fillText()
	haggle.show()
	haggleDialogue.show()
	haggleBar.show()
	haggleDirective.show()

func onStartBeg():
	actions.hide()
	strangerSprite.hide()

func _on_stranger_refresh_why_do_i_need_this(theValue: Variant) -> void:
	pass # Replace with function body.
	if theValue == 0:
		genStrangers()

func _on_scavenge_button_open_scav_wind() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_event_log_open_log() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_ledger_button_open_ledger() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_quota_button_open_quota() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_inventory_button_open_inventory() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_buy_button_open_shop() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_vitals_button_open_vitals() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_skills_button_open_skill_tree() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
func _on_digital_clock_open_time() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	blankSlate()
