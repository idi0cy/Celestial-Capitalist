extends Node2D

@onready var myBackground = get_node("popupBg")
@onready var cashReqLabel = get_node("requirements/cashRequirement/Label")
@onready var ledger = get_node("../Ledger")
@onready var grandProgBar = get_node("../../CelestialSegment/quotaBar")
@onready var progressBarText = get_node("../../CelestialSegment/progressLabel")

@onready var allReqLabels = [cashReqLabel]
@onready var currentlySelected = "cashReqLabel"

var tasksDone = 0
var firstTaskDone = false
var cashReqProgress = 0

func _ready():
	hide()
	cashReqLabel.set("theme_override_colors/font_color", Color(1.0, 1.0, 0.0, 1.0))

func _process(_delta):
	if visible == true:
		cashReqLabel.text = "Make five hundred dollars (" + str(floor(100 * (cashReqProgress * 1.0 / 500))) + "%)"
	if currentlySelected == "none":
		grandProgBar.value = tasksDone / 1.0 * 100
		progressBarText.text = str(tasksDone) + "/1 tasks completed"
	elif currentlySelected == "cashReqLabel":
		grandProgBar.value = cashReqProgress / 500.0 * 100
		progressBarText.text = str(cashReqProgress) + "/500     (" + str(cashReqProgress / 500.0 * 100) + "%)"
	if firstTaskDone == false and cashReqProgress / 500.0 >= 1:
		firstTaskDone = true
		tasksDone += 1

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

func _on_ledger_progress_task(value: Variant) -> void:
	cashReqProgress += value

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
