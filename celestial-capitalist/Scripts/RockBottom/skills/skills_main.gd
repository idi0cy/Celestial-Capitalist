extends Node2D

@onready var pointCount = get_node("pointCount")

#region | Skill point divestment clarifications
var points = 21 #Should start at zero, this is a temporary change for debug purposes
var dextPoints = 0
var dextMod = 0.9
var strengthPoints = 0
var strengthMod = 0.9
var charismaPoints = 0
var charismaMod = 0.9
var percPoints = 0
var percMod = 0.9
var luckPoints = 0 #i think this would only apply to the random events or something
var luckMod = 0.9
#endregion

func _ready():
	hide()
	pointCount.text = "Skill Points: " + str(points)

func _on_skills_button_open_skill_tree() -> void:
	if visible == true:
		hide()
	else:
		show()
		pointCount.text = "Skill Points: " + str(points)

#region | Inputs from other window buttons to hide this one
func _on_vitals_button_open_vitals() -> void:
	hide()
func _on_buy_button_open_shop() -> void:
	hide()
func _on_inventory_button_open_inventory() -> void:
	hide()
func _on_quota_button_open_quota() -> void:
	hide()
func _on_ledger_button_open_ledger() -> void:
	hide()
func _on_event_log_open_log() -> void:
	hide()
func _on_sell_button_open_sell_wind() -> void:
	hide()
func _on_scavenge_button_open_scav_wind() -> void:
	hide()
#endregion
