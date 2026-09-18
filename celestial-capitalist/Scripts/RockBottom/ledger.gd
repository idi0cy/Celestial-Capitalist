extends Node2D

@onready var innerTransactionContainer = $transactionContainer/innerTransactionContainer
@onready var balance = $sidebar/balance
@onready var quota = get_node("../Quota")

const entry_scene = preload("res://ButtonScenes/RockBottom/transaction_entry.tscn")
var money = 0
var highest = money
var ledgerOpen = false

signal progressTask(value)

func _on_open_ledger() -> void:
	openLedger()

func _process(_delta):
	if (money < 0):
		balance.text = "-$" + str(abs(money))
	else:
		balance.text = "$" + str(money)
	if ledgerOpen == false:
		self.hide()
	else:
		self.show()
		
func openLedger():
	ledgerOpen = not ledgerOpen

func addEntry(amount, time, party, subject, texture, deduction : float = 0):
	var entry_instance = entry_scene.instantiate()
	innerTransactionContainer.add_child(entry_instance)
	entry_instance.writeTransaction(amount, time, party, subject, texture)
	changeBalance(amount)
	if amount > 0:
		if quota.cashReqProgress + amount - deduction > 0:
			quota.cashReqProgress += amount - deduction

func changeBalance(value):
	money += value
	if money > highest:
		highest = money
	if value > 0:
		progressTask.emit(value)

#func _input(event):
#	if event.is_action_pressed("debug"):
#		quota.cashReqProgress = 500
#		quota.skillReqProgress = 15
#		quota.sellReqProgress = 10

func _on_scavenge_button_open_scav_wind() -> void:
	ledgerOpen = false
func _on_sell_button_open_sell_wind() -> void:
	ledgerOpen = false
func _on_event_log_open_log() -> void:
	ledgerOpen = false
func _on_inventory_button_open_inventory() -> void:
	ledgerOpen = false
func _on_quota_button_open_quota() -> void:
	ledgerOpen = false
func _on_buy_button_open_shop() -> void:
	ledgerOpen = false
func _on_vitals_button_open_vitals() -> void:
	ledgerOpen = false
func _on_skills_button_open_skill_tree() -> void:
	ledgerOpen = false
