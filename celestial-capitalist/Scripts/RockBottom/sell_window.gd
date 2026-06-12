extends Node2D

#Options so far are as follows
#Beg, Sales Pitch, Fake Injury, Steal, Con

@onready var clock = get_node("../../digitalClock")
@onready var personNameLabel = get_node("PickTarget/personName")
@onready var approachButton = get_node("PickTarget/approachButton/Button")
@onready var approachButtonGeneral = get_node("PickTarget/approachButton")
@onready var PeopleList = get_node("PickTarget/PeopleList")
@onready var directiveFirst = get_node("PickTarget/Directive")
@onready var postApproach = get_node("postApproach")
@onready var actions = get_node("postApproach/Actions")
@onready var strangerSprite = get_node("postApproach/theGuy")
@onready var confirmAction = get_node("postApproach/Actions/takeAction")
@onready var terminal = get_node("postApproach/Terminal")
@onready var terminalText = get_node("postApproach/Terminal/termText")
@onready var minigameWindows = get_node("postApproach/minigameWindows")
@onready var pickToSell = get_node("postApproach/minigameWindows/pickToSell")
@onready var haggle = get_node("postApproach/minigameWindows/Haggle")
@onready var haggleDialogue = get_node("postApproach/minigameWindows/Haggle/dialogue")
@onready var hagglePricing = get_node("postApproach/minigameWindows/Haggle/pricing")
@onready var haggleBar = get_node("postApproach/minigameWindows/Haggle/haggleBar")
@onready var haggleDirective = get_node("postApproach/minigameWindows/Haggle/Directive")
@onready var aimTrainZone = get_node("postApproach/minigameWindows/Haggle/aimTrainZone")
@onready var spectrumOfBall = get_node("postApproach/minigameWindows/Haggle/pricing/spectrumOfBall")

#stands for 'person sprite'
@onready var psPlaceholder = load("res://assets/Sprites/RockBottom/streetRoamers/personPlaceholder.png")
@onready var personButtonScript = load("res://Scripts/RockBottom/stranger_button.gd")

var sellWindowOpen = false
var random
var random2
var temporaryList = []
var alreadyFound = []
var placeHolder
var needToFind
var strangerButton
var initiatingAction = false

#AS OF NOW INDEX 2 IS VESTIGIAL IN FUNCTION UNLESS WE WANT INSTANT REJECTIONS FROM STRANGERS

#try to have more success rate the higher the values are for uniformity
#index 0 is name of person, index 1 is wealth, index 2 is approachability
#3 empathy (beg effectiveness), 4 persuadable (sales), 5 guillable (fake injury)
#6 unassuming (steal stealth), 7 weakness (steal strength)
#8 risk taking (con) 0.4
const richAndOld = ["Rich Old Person", 0.9, 0.4, 0.5, 0.5, 0.7, 0.5, 0.8, 0.2]
const anotherHomeless = ["Homeless", 0.1, 0.8, 0.2, 0.1, 0.1, 0.7, 0.5, 0.7]
const middleAgedAverage = ["Average Middle Aged", 0.6, 0.7, 0.7, 0.6, 0.5, 0.3, 0.2, 0.5]
#For the kid, only display "kid", and have them be harder to predict
const niceKid = ["Child", 0.2, 0.6, 0.9, 0.8, 0.0, 0.9, 0.5, 1, 0.8]
const skepticKid = ["Child 2", 0.3, 0.4, 0.2, 0.2, 0.0, 0.7, 1, 0.2]
const charityWorker = ["Charity Worker", 0.5, 1, 0.9, 0.5, 0.4, 0.3, 0.4, 0.2]

const allStrangers = [richAndOld, anotherHomeless, middleAgedAverage, niceKid, skepticKid, charityWorker]

func _ready():
	haggleDialogue.hide()
	postApproach.hide()
	haggle.hide()
	$PickTarget.show()
	personNameLabel.targetText = ""
	personNameLabel.text = ""
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
		directiveFirst.show()
		#genStrangers()

func genStrangers():
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
	for i in random:
		random2 = randi_range(0, (len(temporaryList) - 1))
		while alreadyFound.has(random2):
			random2 = randi_range(0, (len(temporaryList) - 1))
		strangerButton = TextureButton.new()
		strangerButton.texture_normal = psPlaceholder
		strangerButton.name = str(allStrangers[random2][0])
		strangerButton.set_script(personButtonScript)
		strangerButton.baseInfo = allStrangers[random2]
		strangerButton.pressed.connect(identifyTarget.bind((random2)))
		PeopleList.add_child(strangerButton)
		alreadyFound.append(random2)

func blankSlate():
	directiveFirst.show()
	personNameLabel.show()
	#for item in PeopleList.get_children():
		#PeopleList.remove_child(item)
		#item.queue_free()
	personNameLabel.text = ""
	haggle.hide()
	haggleDialogue.hide()
	hagglePricing.hide()
	aimTrainZone.hide()
	spectrumOfBall.hide()
	terminalText.targetText = ""
	terminalText.fillText()
	pickToSell.closeIcons()
	haggleBar.hide()
	haggleDirective.hide()
	terminal.hide()
	initiatingAction = false
	approachButtonGeneral.hide()

func identifyTarget(index):
	personNameLabel.targetText = allStrangers[index][0]
	personNameLabel.fillText()
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
	approachButton.pressed.connect(approachStranger.bind(index))
	approachButtonGeneral.show()

func approachStranger(index):
	confirmAction.personIndex = index
	
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
		fakeInjury(target)
	elif theAction == "Steal":
		steal(target)
	elif theAction == "Con":
		conTarget(target)
	else:
		noAction(target)

func noAction(target):
	if initiatingAction == false:
		print(target)
		terminalText.targetText = "> System: No action taken. Please select an action before taking it."
		terminalText.fillText()

func salesPitch(target):
	if initiatingAction == false:
		initiatingAction = true
		print(target)
		terminalText.targetText = "> System: Trying to impress customers..."
		terminalText.fillText()
		#maybe play cool sound effect while waiting
		await get_tree().create_timer(2).timeout
		$postApproach/minigameWindows.show()
		pickToSell.openPickToSell()
		haggle.target = target

func begAction(target):
	if initiatingAction == false:
		initiatingAction = true
		print(target)
		terminalText.targetText = "> System: Preparing to cry..."
		terminalText.fillText()

func fakeInjury(target):
	if initiatingAction == false:
		initiatingAction = true
		print(target)
		terminalText.targetText = "> System: Weakening ankles..."
		terminalText.fillText()

func steal(target):
	if initiatingAction == false:
		initiatingAction = true
		print(target)
		terminalText.targetText = "> System: Eyeing enemy pockets..."
		terminalText.fillText()

func conTarget(target):
	if initiatingAction == false:
		initiatingAction = true
		print(target)
		terminalText.targetText = "> System: Ideating new scams..."
		terminalText.fillText()

func _on_confirm_confirm_selection() -> void:
	pass # Replace with function body.
	actions.hide()
	strangerSprite.hide()
	terminalText.targetText = "System: Use above strategies to convince the target. Each strategy has different risk factor to it, which determines both difficulty and reward."
	terminalText.fillText()
	haggle.show()
	haggleDialogue.show()
	haggleBar.show()
	haggleDirective.show()

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
