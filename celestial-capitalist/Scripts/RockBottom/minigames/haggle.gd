class_name Haggle
extends Resources
## Controls the haggle/sales pitch minigame.

#region nodes
@onready var clock  = get_node("../../../../../digitalClock")
@onready var haggleBar = get_node("haggleBar")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWindow = get_node("../../../../sellWind")
@onready var dialogueOptions = get_node("dialogue")
@onready var aimTrainZone = get_node("aimTrainZone")
@onready var pricingPlans = get_node("pricing")
@onready var confirmItem = get_node("../pickToSell/confirm")
@onready var priceSpectrum = get_node("pricing/priceSpectrum")
@onready var ledger = get_node("../../../../Ledger")
@onready var pickToSell = get_node("../pickToSell")
@onready var absInventory = get_node("../../../../inventoryWind")
@onready var peopleList = get_node("../../../../sellWind/PickTarget/PeopleList")
@onready var skill = get_node("../../../../Skills")
#endregion

#region variables
## Controls the progress/score of the game.
@onready var progress = 0

## The amount of red/green targets that will show up throughout the game.
const iterations = 15

## The index of the current stranger in the [StrangerList].
var storedStrangerIndex : int
## The red portion of the progress bar.
var redBar = StyleBoxFlat.new()
## The green portion of the progress bar.
var greenBar = StyleBoxFlat.new()
var random
var random2
var random3 #this is for determining if you gain a skill point
var target
var iterations = 15
var arguedValue
var normalValue
var ballSpectrum = 50
## The id of the stranger for use in the [member SellWindow.allStrangers] list. Not the index in the [StrangerList].
var targetID
## The price selected to sell the item for, as a percentage, e.g. default 50 is the middle/normal price.
var selectedPrice = 50
#endregion

#region game
func _ready():
	redBar.bg_color = Color(1.0, 0.353, 0.0, 1.0)
	greenBar.bg_color = Color(0.387, 1.0, 0.356, 1.0)
	aimTrainZone.hide()
	pricingPlans.hide()
	priceSpectrum.hide()

## Changes progress bar color based on [member progress].
func _process(_delta):
	if progress < 0:
		progress = 0
	if progress < 50:
		haggleBar.add_theme_stylebox_override("fill", redBar)
		haggleBar.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
		haggleBar.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 1.0))
	else:
		haggleBar.add_theme_stylebox_override("fill", greenBar)
		haggleBar.add_theme_color_override("font_color", Color())
		haggleBar.add_theme_color_override("font_outline_color", Color(1.0, 1.0, 1.0, 1.0))

## Triggered on picking the promote option. Starts the minigame with risk 1.5 and sends appropriate line.
func _on_promote_promote() -> void:
	terminalText.targetText = "> You: " + promoteLines.pick_random() + "\n"
	terminalText.fillText()
	universalMinigame(1.5)

## Triggered on picking the promote option. Starts the minigame with risk 1.25 and sends appropriate line.
func _on_urgency_urgency() -> void:
	terminalText.targetText = "> You: " + urgencyLines.pick_random() + "\n"
	terminalText.fillText()
	universalMinigame(1.25)

## Triggered on picking the promote option. Starts the minigame with risk 1.0 and sends appropriate line.
func _on_recommend_recommend() -> void:
	terminalText.targetText = "> You: " + recommendLines.pick_random() + "\n"
	terminalText.fillText()
	universalMinigame(1.0)

## Triggered on picking the promote option. Starts the minigame with risk 2.0 and sends appropriate line.
func _on_fearmonger_fear_monger() -> void:
	terminalText.targetText = "> You: " + fearmongerLines.pick_random() + "\n"
	terminalText.fillText()
	universalMinigame(2.0)

## Starts the target minigame with [param risk]. Targets last for 1/[param risk] seconds and appear [member iterations] times.
func universalMinigame(risk):
	dialogueOptions.hide()
	aimTrainZone.show()
	for item in $aimTrainZone.get_children():
		$aimTrainZone.remove_child(item)
		item.queue_free()
	for i in iterations:
		## Used to construct the green target every iteration.
		var greenTarget = TextureButton.new()
		greenTarget.global_position = Vector2(randi_range(360,752), randi_range(240,305))
		greenTarget.texture_normal = goodTarget
		greenTarget.texture_pressed = goodTarget
		greenTarget.set_script(targetScript)
		$aimTrainZone.add_child(greenTarget)
		greenTarget.initiate("good", risk)
		
		## Used to construct the red target every iteration.
		var redTarget = TextureButton.new()
		redTarget.global_position = Vector2(randi_range(360,752), randi_range(240,305))
		redTarget.texture_normal = badTarget
		redTarget.texture_pressed = badTarget
		redTarget.set_script(targetScript)
		$aimTrainZone.add_child(redTarget)
		redTarget.initiate("bad", risk)
		
		if i != iterations:
			await get_tree().create_timer(1).timeout
		else:
			await get_tree().create_timer(2).timeout
	
	aimTrainZone.hide()
	pricingPlans.show()
	priceSpectrum.show()
#endregion

#region balling/choosing pricing

## Lower price
func _on_lowball_lowball() -> void:
	if selectedPrice > 0:
		selectedPrice -= 10

## Raise price
func _on_highball_highball() -> void:
	if selectedPrice < 100:
		selectedPrice += 10

## Triggers when the player settles on a price. [br]
## [br]
## 1. Get the name of the current stranger from the [TextureButton] and [storedStrangerIndex], and process it. [br]
## 2. Calculate [member arguedValue] based on item's price and [member selectedPrice]. [br]
## 3. If a random percentage * [member arguedValue]/[member normalValue] IS SMALLER THAN [member progress] 
## game succeeds. The [Terminal] reports the amount received, sends it to the [Ledger], and outputs dialogue. If else, dialogue reports a fail. [br]
## 4. Wait for a bit for the player to read it. Exit the screen.
func _on_settle() -> void:
	#1.
	## The regex engine.
	var regex = RegEx.new()
	regex.compile("\\d")
	## The unique name of the current stranger.
	var generatedName = peopleList.get_child(storedStrangerIndex).name
	if (regex.search(generatedName)):
		generatedName = generatedName.left(-1)
	arguedValue = confirmItem.selected[1] * (confirmItem.selected[0][2] * 0.01) * ((ballSpectrum * 0.01) + 0.5)
	normalValue = confirmItem.selected[1] * (confirmItem.selected[0][2] * 0.01)
	#print((random2 * 100) *(arguedValue / normalValue))
	

	#2.
	## The value the item is being sold for after being modified by the [member selectedPrice].
	var arguedValue = confirmItem.selected[3] * ((selectedPrice * 0.01) + 0.5)
	## The item's regular value from base value and quality.
	var normalValue = confirmItem.selected[3]
	
	#3.
	if (randf() * 100) * (arguedValue / normalValue) < progress * skill.charismaMod:
		ledger.money += arguedValue
		ledger.addEntry(arguedValue, clock.theTime, sellWindow.allStrangers[targetID][0], confirmItem.selected[0][0], confirmItem.selected[0][-1])
		if (getEasterEggLine(generatedName) == "false"):
			terminalText.targetText = "> " + generatedName + ": " + acceptLines.pick_random()
		else:
			terminalText.targetText = "> " + generatedName + ": " + getEasterEggLine(generatedName)
		terminalText.targetText += "\n> System: Received $" + str(arguedValue)
		absInventory.removeItem(confirmItem.selectedIndex)
	else:
		if (getEasterEggLine(generatedName) == "false"):
			terminalText.targetText = "> " + generatedName + ": " + rejectLines.pick_random()
		else:
			terminalText.targetText = "> " + generatedName + ": " + getEasterEggLine(generatedName)
		sellWindow.removeStranger(sellWindow.currentStrangerIndex)
	
	#determine if skill point is gained
	random3 = randf()
	if random3 >= 0.85:
		skill.points += 1
	
	terminalText.fillText()
	
	#4.
	await get_tree().create_timer(4).timeout
	progress = 0
	pickToSell.closeIcons()
	sellWindow.reset()
	sellWindow.onButton()
#endregion
