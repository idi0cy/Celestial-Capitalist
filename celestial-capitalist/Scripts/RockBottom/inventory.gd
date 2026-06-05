extends Node2D

var hiding = true

#Index 0 is item name, 1 is type, 2 is value, 3 is whatever the hell else I decide
#interpret values with "null" in them as not having that property/value attached to the item
const waterBottle = ["Water Bottle", "Consumable", "2", "null"]
const pencil = ["Pencil", "Garbage", "1", "null"]

#replace when implimenting save game function (WHYYYYY DO I HAVE TO FIGURE THAT OUT?????)
var currentInv = []

func _process(_delta):
	if hiding == true:
		self.hide()
	else:
		self.show()

func _on_inventory_button_open_inventory() -> void:
	hiding = not hiding


func _on_scavenge_button_open_scav_wind() -> void:
	hiding = true
func _on_sell_button_open_sell_wind() -> void:
	hiding = true
func _on_event_log_open_log() -> void:
	hiding = true
func _on_ledger_button_open_ledger() -> void:
	hiding = true
func _on_quota_button_open_quota() -> void:
	hiding = true
func _on_buy_button_open_shop() -> void:
	hiding = true
func _on_vitals_button_open_vitals() -> void:
	hiding = true
