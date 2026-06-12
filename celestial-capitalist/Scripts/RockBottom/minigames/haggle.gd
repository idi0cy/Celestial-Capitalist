extends Node2D

@onready var haggleBar = get_node("haggleBar")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWindow = get_node("../../../../sellWind")
@onready var dialogueOptions = get_node("dialogue")
@onready var aimTrainZone = get_node("aimTrainZone")
@onready var pricingPlans = get_node("pricing")
@onready var confirmItem = get_node("../pickToSell/confirm")
@onready var spectrumOfBall = get_node("pricing/spectrumOfBall")
@onready var ledger = get_node("../../../../Ledger")
@onready var pickToSell = get_node("../pickToSell")
@onready var absInventory = get_node("../../../../inventoryWind")
@onready var allStrangers = sellWindow.allStrangers


@onready var goodTarget = load("res://assets/Sprites/RockBottom/buttonIcons/goodTarget.png")
@onready var badTarget = load("res://assets/Sprites/RockBottom/buttonIcons/badTarget.png")

@onready var targetScript = load("res://Scripts/RockBottom/minigames/haggle_target.gd")

@onready var progress = 0

var redBar = StyleBoxFlat.new()
var greenBar = StyleBoxFlat.new()
var random
var random2
var target
var iterations = 15
var arguedValue
var normalValue
var ballSpectrum = 50

func _ready():
	redBar.bg_color = Color(1.0, 0.353, 0.0, 1.0)
	greenBar.bg_color = Color(0.387, 1.0, 0.356, 1.0)
	aimTrainZone.hide()
	pricingPlans.hide()
	spectrumOfBall.hide()

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


func _on_promote_promote() -> void:
	terminalText.targetText = "> You: This one can cure cancer! \n"
	terminalText.fillText()
	universalMinigame(1.5)

func _on_urgency_urgency() -> void:
	terminalText.targetText = "> You: This won't be available tomorrow. \n"
	terminalText.fillText()
	universalMinigame(1.25)

func _on_recommend_recommend() -> void:
	terminalText.targetText = "> You: I would highly recommend this prodcut. \n"
	terminalText.fillText()
	universalMinigame(1.0)

func _on_fearmonger_fear_monger() -> void:
	terminalText.targetText = "> You: If you don't buy this, you'll die. \n"
	terminalText.fillText()
	universalMinigame(2.0)

func universalMinigame(risk):
	dialogueOptions.hide()
	aimTrainZone.show()
	for item in $aimTrainZone.get_children():
		$aimTrainZone.remove_child(item)
		item.queue_free()
	for i in iterations:
		var greenTarget = TextureButton.new()
		greenTarget.global_position = Vector2(randi_range(360,752), randi_range(240,305))
		greenTarget.texture_normal = goodTarget
		greenTarget.texture_pressed = goodTarget
		greenTarget.set_script(targetScript)
		$aimTrainZone.add_child(greenTarget)
		greenTarget.initiate("good", risk)
		
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
	pricing()

#super vestigial function
func pricing():
	pricingPlans.show()
	spectrumOfBall.show()

func _on_lowball_lowball() -> void:
	if ballSpectrum > 0:
		ballSpectrum -= 10

func _on_highball_highball() -> void:
	if ballSpectrum < 100:
		ballSpectrum += 10

func _on_goldilocks_ball() -> void:
	random2 = randf()
	arguedValue = confirmItem.selected.myItem[1] * (confirmItem.selected.baseItem[2] * 0.01) * ((ballSpectrum * 0.01) + 0.5)
	normalValue = confirmItem.selected.myItem[1] * (confirmItem.selected.baseItem[2] * 0.01)
	#print((random2 * 100) *(arguedValue / normalValue))
	if (random2 * 100) * (arguedValue / normalValue) < progress:
		ledger.money += arguedValue
		terminalText.targetText = "> " + allStrangers[target][0] + ": I'll take it."
		absInventory.removeItem(confirmItem.selectedIndex)
	else:
		terminalText.targetText = "> " + allStrangers[target][0] + ": Never speak to me ever again."
	terminalText.fillText()
	await get_tree().create_timer(2).timeout
	progress = 0
	pickToSell.closeIcons()
	sellWindow.blankSlate()
	sellWindow.onButton()
