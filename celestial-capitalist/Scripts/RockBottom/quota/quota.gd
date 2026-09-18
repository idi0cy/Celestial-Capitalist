extends Node2D

@onready var myBackground = get_node("popupBg")
@onready var cashReqLabel = get_node("requirements/cashRequirement/Label")
@onready var skillReqLabel = get_node("requirements/skillRequirement/Label")
@onready var sellReqLabel = get_node("requirements/sellRequirement/Label")
@onready var ledger = get_node("../Ledger")
@onready var grandProgBar = get_node("../../CelestialSegment/quotaBar")
@onready var progressBarText = get_node("../../CelestialSegment/progressLabel")

@onready var completeTexture = preload("res://assets/Sprites/RockBottom/quotaSprites/checkedCheckbox.png")

#@onready var allReqLabels = [cashReqLabel]
@onready var currentlySelected = "cashReqLabel"

var tasksDone = 0
var firstTaskDone = false
var secondTaskDone = false
var thirdTaskDone = false
var signalledAlready = false
var cashReqProgress = 0
var skillReqProgress = 0
var sellReqProgress = 0

signal quotaMet

func _ready():
	hide()
	cashReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 0.0, 1.0))

func _process(_delta):
	if tasksDone == 3 and signalledAlready == false:
		signalledAlready = true
		quotaMet.emit()
		$completePopup.show()
	
	if visible == true:
		if cashReqProgress / 500.0 * 100 < 100:
			cashReqLabel.text = "Make five hundred (500) dollars [" + str(floor(100 * (cashReqProgress * 1.0 / 500))) + "%]"
		else:
			cashReqLabel.text = "Make five hundred (500) dollars [100%]"
		if skillReqProgress / 15.0 * 100 < 100:
			skillReqLabel.text = "Gain fifteen (15) skill points [" + str(floor(100*(skillReqProgress/15.0))) + "%]"
		else:
			skillReqLabel.text = "Gain fifteen (15) skill points [100%]"
		if sellReqProgress / 10.0 * 100 < 100:
			sellReqLabel.text = "Sell ten (10) items [" + str(floor(100*(sellReqProgress/10.0))) + "%]"
		else:
			sellReqLabel.text = "Sell ten (10) items [100%]"
	
	if currentlySelected == "none":
		grandProgBar.value = tasksDone / 3.0 * 100
		progressBarText.text = str(tasksDone) + "/3 tasks completed"
	elif currentlySelected == "cashReqLabel":
		grandProgBar.value = cashReqProgress / 500.0 * 100
		if cashReqProgress / 500.0 * 100 < 100:
			progressBarText.text = str(cashReqProgress) + "/500     [" + str(floor(cashReqProgress / 500.0 * 100)) + "%]"
		else:
			progressBarText.text = "500/500     [100%]"
	elif currentlySelected == "skillReqLabel":
		grandProgBar.value = skillReqProgress / 15.0 * 100
		if skillReqProgress / 15.0 * 100 < 100:
			progressBarText.text = str(skillReqProgress) + "/15     [" + str(floor(skillReqProgress/15.0 * 100)) + "%]"
		else:
			progressBarText.text = "15/15     [100%]"
	elif currentlySelected == "sellReqLabel":
		grandProgBar.value = sellReqProgress / 10.0 * 100
		if sellReqProgress/10.0 * 100 < 100:
			progressBarText.text = str(sellReqProgress) + "/10     [" + str(floor(sellReqProgress/10.0 * 100)) + "%]"
		else:
			progressBarText.text = "10/10     [100%]"
	if firstTaskDone == false and cashReqProgress / 500.0 >= 1:
		firstTaskDone = true
		tasksDone += 1
		$requirements/cashRequirement/inquire/interactable.icon = completeTexture
	if secondTaskDone == false and skillReqProgress/15.0 >= 1:
		secondTaskDone = true
		tasksDone += 1
		$requirements/skillRequirement/inquire/interactable.icon = completeTexture
	if thirdTaskDone == false and sellReqProgress/10.0 >= 1:
		thirdTaskDone = true
		tasksDone += 1
		$requirements/sellRequirement/inquire/interactable.icon = completeTexture
	#if Input.is_action_just_pressed("r"):
		#ledger.addEntry(50, 0, "God", "Donated", completeTexture)

func _on_quota_button_open_quota() -> void:
	if visible == true:
		visible = false
	else:
		visible = true

func _on_inquire_open_cash_inquiry() -> void:
	if currentlySelected == "cashReqLabel":
		cashReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
		currentlySelected = "none"
	else:
		cashReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 0.0, 1.0))
		currentlySelected = "cashReqLabel"
		skillReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
		sellReqLabel.set("theme_override_colors/font_color", Color(1, 1, 1, 1))

func _on_inquire_open_skill_inquiry() -> void:
	if currentlySelected == "skillReqLabel":
		skillReqLabel.set("theme_override_colors/font_color", Color(1, 1, 1, 1))
		currentlySelected = "none"
	else:
		skillReqLabel.set("theme_override_colors/font_color", Color(1, 1, 0, 1))
		currentlySelected = "skillReqLabel"
		cashReqLabel.set("theme_override_colors/font_color", Color(1, 1, 1, 1))
		sellReqLabel.set("theme_override_colors/font_color", Color(1, 1, 1, 1))

func _on_inquire_open_sell_inquiry() -> void:
	if currentlySelected == "sellReqLabel":
		sellReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
		currentlySelected = "none"
	else:
		sellReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 0.0, 1.0))
		currentlySelected = "sellReqLabel"
		cashReqLabel.set("theme_override_colors/font_color", Color(1, 1, 1, 1))
		skillReqLabel.set("theme_override_colors/font_color", Color(1, 1, 1, 1))

#func _on_ledger_progress_task(value: Variant) -> void:
#	cashReqProgress += value

func _on_scavenge_button_open_scav_wind() -> void:
	hide()
func _on_sell_button_open_sell_wind() -> void:
	hide()
func _on_event_log_open_log() -> void:
	hide()
func _on_ledger_button_open_ledger() -> void:
	hide()
func _on_inventory_button_open_inventory() -> void:
	hide()
func _on_buy_button_open_shop() -> void:
	hide()
func _on_vitals_button_open_vitals() -> void:
	hide()
func _on_skills_button_open_skill_tree() -> void:
	hide()
