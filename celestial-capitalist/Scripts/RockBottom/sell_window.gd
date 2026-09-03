class_name SellWindow
extends Resources
## Controls the window that opens after clicking the 'Get Money' button.
##
## Handles stranger generation and options to get money from them.

#region nodes
#general
@onready var clock = get_node("../../digitalClock")
@onready var personNameLabel = get_node("PickTarget/personName")
@onready var approachButton = get_node("PickTarget/approachButton/interactable")
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
@onready var minigameWindows = get_node("postApproach/minigameWindows")

#minigame HAGGLE
@onready var pickToSell = get_node("postApproach/minigameWindows/pickToSell")
@onready var haggle = get_node("postApproach/minigameWindows/Haggle")
@onready var haggleDialogue = get_node("postApproach/minigameWindows/Haggle/dialogue")
@onready var hagglePricing = get_node("postApproach/minigameWindows/Haggle/pricing")
@onready var haggleBar = get_node("postApproach/minigameWindows/Haggle/haggleBar")
@onready var haggleDirective = get_node("postApproach/minigameWindows/Haggle/Directive")
@onready var aimTrainZone = get_node("postApproach/minigameWindows/Haggle/aimTrainZone")
@onready var priceSpectrum = get_node("postApproach/minigameWindows/Haggle/pricing/priceSpectrum")

#minigame BEG
@onready var begWindow = get_node("postApproach/minigameWindows/Beg")

#minigame FAKE INJURY
@onready var fakeInjury = get_node("postApproach/minigameWindows/FakeInjury")
@onready var fakeInjurySeverity = get_node("postApproach/minigameWindows/FakeInjury/severityPick")
@onready var fakeInjuryMinigame = get_node("postApproach/minigameWindows/FakeInjury/minigamePart")

#minigame CON
@onready var conGame = get_node("postApproach/minigameWindows/Con")
@onready var conRisk = get_node("postApproach/minigameWindows/Con/Severity")

#minigame STEAL
@onready var stealGame = get_node("postApproach/minigameWindows/Steal")
@onready var stealOptions = get_node("postApproach/minigameWindows/Steal/options")
@onready var stealStrength = get_node("postApproach/minigameWindows/Steal/strengthGame")
@onready var stealStealth = get_node("postApproach/minigameWindows/Steal/stealthGame")

#endregion

#region variables
## Controls whether the window is open or closed.
var sellWindowOpen = false
## Prevents player from exiting the window when true. Should be true when playing a minigame
var initiatingAction = false
## Sent to action windows so they can remove the current stranger from the list if the player fails the game.
var currentStrangerIndex

## List of all strangers registered using [method SellWindow.newStranger]. Used to get data of a default stranger at runtime. Access a stranger using its name as key.
@onready var allStrangers : Dictionary = {}
#endregion

#region stranger creation
## Method for creating new strangers. Used instead of just assigning an array to operate on each stranger on ready. 
## Appends items to [member allStrangers] using their name as [code]key:stranger[/code]. [br]
## [br]
## [b]Stranger Indexes:[/b] [br]
## Most personality values allow for higher success rate the higher they are. idi0cy needs to clarify this. [br]
## [br]
## 0 name/id, [br]
## 1 is wealth, [br]
## 2 is approachability, [br]
## 3 empathy (beg), [br]
## 4 persuadability (sales), [br]
## 5 guillibility (fake injury), [br]
## 6 unassumingness (steal stealth), [br]
## 7 weakness (steal strength), [br]
## 8 riskReceptiveness (con), [br]
## 9 texture.
func newStranger (
	strangerName:String,
	wealth:float, approachability:float, empathy:float, persuadability:float,
	guillibility:float, unassumingness:float, weakness:float, riskReceptiveness:float,
	texture:Texture2D):
		var stranger = [strangerName,
		wealth, approachability, empathy, persuadability,
		guillibility, unassumingness, weakness, riskReceptiveness,
		texture]
		allStrangers[strangerName] = stranger
		return stranger
#endregion

#region strangers
@onready var richAndOld = newStranger(
	"Rich Old Person",
	0.9, 0.4, 0.5, 0.5,
	0.6, 0.5, 0.8, 0.2,
	richOldIcon)
@onready var anotherHomeless = newStranger(
	"Homeless",
	0.1, 0.8, 0.2, 0.1,
	0.1, 0.7, 0.5, 0.7,
	homelessIcon)
@onready var middleAgedAverage = newStranger(
	"Average Middle Aged",
	0.6, 0.7, 0.7, 0.6,
	0.5, 0.3, 0.2, 0.5,
	averageMiddleAgedIcon)
#For the kid, only display "kid", and have them be harder to predict
@onready var niceKid = newStranger(
	"Child",
	0.2, 0.6, 0.9, 0.8,
	0.9, 0.5, 1, 0.8,
	childIcon)
@onready var skepticKid = newStranger(
	"Child",
	0.3, 0.4, 0.2, 0.2,
	0.0, 0.7, 1, 0.2,
	childIcon)
@onready var charityWorker = newStranger(
	"Charity Worker",
	0.5, 1, 0.9, 0.5,
	0.4, 0.3, 0.4, 0.2,
	charityWorkerIcon)
#endregion

func _ready():
	reset()
	for item in PeopleList.get_children():
		PeopleList.remove_child(item)
		item.queue_free()
	genStrangers()

func _process(_delta):
	if sellWindowOpen == false:
		self.hide()
	else:
		self.show()

#region stranger logic
## Generates strangers. [br]
## 0. Reset strangers, [br]
## 1. Generate random amount of strangers based on time, [br]
## 2. Assembles stranger [TextureButton]s. [br]
func genStrangers():
	# 0.
	for item in PeopleList.get_children():
		PeopleList.remove_child(item)
		item.queue_free()
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
	approachButtonGeneral.hide()
	personNameLabel.targetText = ""
	personNameLabel.fillText()

	# 1.
	## Amount of strangers.
	var strangerCount : int
	if clock.theTime >= 1320 or clock.theTime <= 300:
		strangerCount = randi_range(0,1)
	elif clock.theTime > 300 and clock.theTime <= 420:
		strangerCount = randi_range(1,2)
	elif clock.theTime > 420 and clock.theTime <= 510:
		strangerCount = randi_range(2,3)
	elif clock.theTime > 510 and clock.theTime <= 600:
		strangerCount = 4
	elif clock.theTime > 600 and clock.theTime <= 960:
		strangerCount = randi_range(2,3)
	elif clock.theTime > 960 and clock.theTime <=1080:
		strangerCount = 4
	else:
		strangerCount = randi_range(3,4)
	
	## Keeps track of how many strangers have been generated and is also used to assign stranger [TextureButton]s an index.
	var index = 0
	# 2.
	for i in strangerCount:
		## Randomly chosen stranger id.
		var randomStranger = allStrangers.keys().pick_random()
		## Used to construct the stranger [TextureButton].
		var strangerButton = TextureButton.new()
		strangerButton.texture_normal = allStrangers[randomStranger][9]
		## Randomly generated name using [method Resources.genName].
		var generatedName = genName(allStrangers[randomStranger][0])
		strangerButton.name = generatedName
		strangerButton.set_script(personButtonScript)
		strangerButton.baseInfo = allStrangers[randomStranger]
		strangerButton.index = index
		strangerButton.pressed.connect(identifyTarget.bind(randomStranger, index, generatedName))
		PeopleList.add_child(strangerButton)
		PeopleList.get_child(index).name = generatedName
		index += 1

## Removes a stranger at an index.
func removeStranger(index):
	## Used in checking which stranger to remove.
	var count = 0
	for obj in PeopleList.get_children():
		if count == index:
			PeopleList.remove_child(obj)
			obj.queue_free()
		count += 1

## Reset the sell window and its derivatives.
func reset():
	#sell window
	currentStrangerIndex = "None"
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
		
	refreshExplanation.targetText = ""
	refreshExplanation.fillText()
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
	priceSpectrum.hide()
	pickToSell.closeIcons()
	haggleBar.hide()
	haggleDirective.hide()
	
	#beg window
	begWindow.hide()
	
	#fake injury window
	fakeInjury.hide()
	fakeInjurySeverity.hide()
	fakeInjuryMinigame.hide()
	
	#con window
	conGame.hide()
	conRisk.hide()
	
	#steal window
	stealGame.hide()
	stealOptions.hide()
	stealStealth.hide()
	stealStrength.hide()
	
	initiatingAction = false

## Displays the name of the currently selected stranger and connects the approach button to its id and index in the list.
func identifyTarget(id, index, displayName):
	personNameLabel.targetText = displayName
	personNameLabel.fillText()
	
	haggle.storedStrangerIndex = index
	fakeInjury.storedStrangerIndex = index
	begWindow.storedStrangerIndex = index
	
	if approachButton.pressed.is_connected(approachStranger):
		approachButton.pressed.disconnect(self.approachStranger)
	approachButton.pressed.connect(approachStranger.bind(id, index))
	approachButtonGeneral.show()

## Executed on pressing the approach button. Shows the actions menu.
func approachStranger(id, place):
	confirmAction.personID = id
	currentStrangerIndex = place
	
	directiveFirst.hide()
	$PickTarget/personName.hide()
	approachButtonGeneral.hide()
	postApproach.show()
	$postApproach/Actions.show()
	strangerSprite.texture = allStrangers[id][9]
	$postApproach/theGuy.show()
	$postApproach/Terminal.show()
	$postApproach/minigameWindows.hide()
	PeopleList.peopleListHidden = true

## Refreshes strangers when timer is up.
func _on_stranger_refresh(theValue: Variant) -> void:
	if theValue == 0:
		genStrangers()
#endregion

#region action logic
## Receives the action taken and offloads the execution to other methods.
func _on_take_action_confirm_action(theAction, targetID) -> void:
	
	if theAction == "No Action":
		noAction(targetID)
	elif theAction == "Sales Pitch":
		salesPitch(targetID)
	elif theAction == "Beg":
		begAction(targetID)
	elif theAction == "Fake Injury":
		fakeInjuryAction(targetID)
	elif theAction == "Steal":
		steal(targetID)
	elif theAction == "Con":
		conTarget(targetID)
	else:
		noAction(targetID)

## Tells the player to pick an action before pressing the button.
func noAction(_target):
	if initiatingAction == false:
		terminalText.targetText = "> System: No action taken. Please select an action before taking it."
		terminalText.fillText()

## Initiates the pick to sell window and haggle minigame.
func salesPitch(targetID):
	if initiatingAction == false:
		initiatingAction = true
		terminalText.targetText = "> System: Trying to impress customers..."
		terminalText.fillText()
		#maybe play cool sound effect while waiting
		await get_tree().create_timer(2).timeout
		minigameWindows.show()
		pickToSell.openPickToSell()
		haggle.targetID = targetID

## Initiates the beg minigame.
func begAction(targetID):
	if initiatingAction == false:
		initiatingAction = true
		terminalText.targetText = "> System: Preparing to cry..."
		terminalText.fillText()
		await get_tree().create_timer(2).timeout
		onStartMinigame()
		begWindow.initiate(targetID)
		minigameWindows.show()

## Initiates the fake injury minigame.
func fakeInjuryAction(targetID):
	if initiatingAction == false:
		initiatingAction = true
		terminalText.targetText = "> System: Weakening ankles..."
		terminalText.fillText()
		await get_tree().create_timer(2).timeout
		#This better work as a substitute
		onStartMinigame()
		fakeInjury.initiate(targetID)
		minigameWindows.show()

## Initiates the steal minigame.
func steal(targetID):
	if initiatingAction == false:
		initiatingAction = true
		#print(targetID)
		terminalText.targetText = "> System: Eyeing enemy pockets..."
		terminalText.fillText()
		await get_tree().create_timer(2).timeout
		onStartMinigame()
		stealGame.initiate(targetID)
		minigameWindows.show()

## Initiates the con minigame.
func conTarget(targetID):
	if initiatingAction == false:
		initiatingAction = true
		#print(targetID)
		terminalText.targetText = "> System: Ideating new scams..."
		terminalText.fillText()
		await get_tree().create_timer(2).timeout
		onStartMinigame()
		conGame.initiate(targetID)
		minigameWindows.show()

## Initiates the haggle minigame.
func _on_confirm_confirm_selection() -> void:
	actions.hide()
	strangerSprite.hide()
	terminalText.targetText = "System: Use above strategies to convince the target. Each strategy has different risk factor to it, which determines both difficulty and reward."
	terminalText.fillText()
	haggle.show()
	haggleDialogue.show()
	haggleBar.show()
	haggleDirective.show()

## Hides actions and the stranger icon.
func onStartMinigame():
	actions.hide()
	strangerSprite.hide()
#endregion
	
#region screen
func _on_sell_button_open_sell_wind() -> void:
	onButton()

## Shows the window.
func onButton():
	initiatingAction = false
	haggleDialogue.hide()
	postApproach.hide()
	terminalText.targetText = ""
	terminalText.fillText()
	reset()
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
		
func _on_scavenge_button_open_scav_wind() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_event_log_open_log() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_ledger_button_open_ledger() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_quota_button_open_quota() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_inventory_button_open_inventory() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_buy_button_open_shop() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_vitals_button_open_vitals() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_skills_button_open_skill_tree() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
func _on_digital_clock_open_time() -> void:
	sellWindowOpen = false
	PeopleList.peopleListHidden = true
	reset()
#endregion
