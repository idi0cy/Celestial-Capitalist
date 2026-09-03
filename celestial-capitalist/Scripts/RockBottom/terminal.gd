extends Node2D

var isOpen:bool = false

func _ready():
	hide()
	
func _process(_delta):
	if isOpen:
		show()
	else:
		hide()

func openTerminal():
	isOpen = not isOpen
	if !isOpen:
		$termText.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_vitals_button_open_vitals() -> void:
	isOpen = false
func _on_scavenge_button_open_scav_wind() -> void:
	isOpen = false
func _on_sell_button_open_sell_wind() -> void:
	isOpen = false
func _on_event_log_open_log() -> void:
	isOpen = false
func _on_inventory_button_open_inventory() -> void:
	isOpen = false
func _on_quota_button_open_quota() -> void:
	isOpen = false
func _on_buy_button_open_shop() -> void:
	isOpen = false
func _on_ledger_button_open_ledger() -> void:
	isOpen = false
func _on_skills_button_open_skill_tree() -> void:
	isOpen = false
func _on_digital_clock_open_time() -> void:
	isOpen = false
