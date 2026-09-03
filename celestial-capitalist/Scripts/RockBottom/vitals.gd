class_name Vitals
extends Resources
## Controls player hydration, satiation, and health, and the window to view them.
##
## Hydration and satiation are affected by food while health is affected by medication items.
## Satiation is the cap for health. Your health will always be lower or equal to your satiation.
## Hydration does not directly affect your health, but when it reaches zero, you enter a dehydrated state.
## While dehydrated, the player suffers damage over time at a constant rate, 
## so it is important to keep satiation up in case of dehydration.

#region nodes
@onready var clock = get_node("../../digitalClock")
@onready var damageOverlay = get_node("../damageOverlay")
@onready var ledger = get_node("../Ledger")
@onready var terminal = get_node("../terminal")
@onready var terminalText = get_node("../terminal/termText")
@onready var healthBar = get_node("healthBar")
@onready var satiationBar = get_node("satiationBar")
@onready var hydrationBar = get_node("hydrationBar")
@onready var healthLabel = get_node("health")
@onready var satiationLabel = get_node("satiation")
@onready var hydrationLabel = get_node("hydration")
@onready var deathScreen = get_node("../deathScreen")
@onready var gameOver = get_node("../deathScreen/gameOver")
@onready var message = get_node("../deathScreen/message")
@onready var stage = get_node("../deathScreen/stage")
@onready var balance = get_node("../deathScreen/balance")
#endregion

#region variables
var health:int = 100
var hydration:int = 100
var satiation:int = 100

## Controls whether the window is open or not.
var vitalsOpen:bool = false
## The name of the current health status, for use in the [Terminal].
var condition:String = "HEALTHY"
## The last in game time since hydration was updated.
var lastHydrationTime:int = 720
## The last in game time since satiation was updated.
var lastSatiationTime:int = 720
## The last in game time since health was updated due to dehydration.
var lastDehydrationTime:int = 720
#endregion

#region vitals logic
func _ready() -> void:
	deathScreen.hide()
	satiationBar.value = satiation
	satiationLabel.text = "Satiation: " + str(satiation) + "%"
	hydrationBar.value = hydration
	hydrationLabel.text = "Hydration: " + str(hydration) + "%"

## Use to change satiation so the call can be intercepted and update the terminal, the window and other satiation dependent things.
func changeSatiation(value:int):
	if (satiation + value) > 100:
		satiation = 100
	elif (satiation + value) < 0:
		satiation = 0
	else:
		satiation += value
	satiationBar.value = satiation
	satiationLabel.text = "Satiation: " + str(satiation) + "%"
	if health > satiation:
		changeHealth(-(health - satiation))
			
## Use to change hydration so the call can be intercepted and update the terminal, the window and other hydration dependent things.
func changeHydration(value:int):
	if (hydration + value) > 100:
		hydration = 100
	elif (hydration + value) < 0:
		hydration = 0
	else:
		hydration += value
	hydrationBar.value = hydration
	hydrationLabel.text = "Hydration: " + str(hydration) + "%"
	if hydration == 0:
		condition = "DEHYDRATED"
		continuousFade()

func _process(_delta: float):
	if clock.theTime == lastSatiationTime + 30:
		changeSatiation(-1)
		lastSatiationTime = clock.theTime
	if clock.theTime == lastHydrationTime + 15:
		changeHydration(-1)
		lastHydrationTime = clock.theTime
	if clock.theTime == lastDehydrationTime + 2:
		if condition == "DEHYDRATED":
			changeHealth(-1)
		lastDehydrationTime = clock.theTime
	
	if vitalsOpen == false:
		hide()
	else:
		show()
		
## Use to change health so the call can be intercepted and update the terminal, the window and other health dependent things.
func changeHealth(value:int):
	
	if (health + value) < 0:
		health = 0
	elif (health + value) > 100:
		health = 100
	else:
		health += value
	
	if health < satiation && value < 0 && condition != "DEHYDRATED":
		damageOverlay.fade(health)
	
	if health == 0:
		condition = "DECEASED"
		if vitalsOpen:
			terminalText.modulate = Color.BLACK
		deathScreen.show()
		gameOver.targetText = "GAME OVER"
		gameOver.fillText()
		message.targetText = deathMessages.pick_random()
		message.fillText()
		stage.targetText = "Rock Bottom | Click anywhere to exit"
		stage.fillText()
		balance.targetText = "Balance: $" + str(ledger.money) + " | Highest: $" + str(ledger.highest)
		balance.fillText()
	elif hydration == 0:
		condition = "DEHYDRATED"
		if vitalsOpen:
			terminalText.modulate = Color.RED
		continuousFade()
	elif health >= 80:
		condition = "HEALTHY"
		if vitalsOpen:
			terminalText.modulate = Color.LIGHT_SEA_GREEN
	elif health >= 60:
		condition = "FAIR"
		if vitalsOpen:
			terminalText.modulate = Color.GREEN
	elif health >= 40:
		condition = "POOR"
		if vitalsOpen:
			terminalText.modulate = Color.YELLOW
	elif health >= 20:
		condition = "UNHEALTHY"
		if vitalsOpen:
			terminalText.modulate = Color.ORANGE
	elif health >= 1:
		condition = "CRITICAL"
		if vitalsOpen:
			terminalText.modulate = Color.RED
		continuousFade()
	healthBar.value = health
	healthLabel.text = "Health: " + str(health) + "%"
	terminalText.targetText = "> System: Your condition is [" + condition + "]"
	terminalText.fillText()

func continuousFade():
	var currentHealth:int = health
	while health == currentHealth && (condition == "DEHYDRATED" || "CRITICAL"):
		damageOverlay.fade(health)
		await get_tree().create_timer(3.5).timeout

func _input(event):
	if event.is_action_pressed("click") && health == 0:
		get_tree().quit()
	if event.is_action_pressed("debug"):
		print("health: " + str(health))
		print("hydration: " + str(hydration))
		print("satiation: " + str(satiation))
	
	#if event.is_action_pressed("q"):
	#	changeHealth(-10)
	#if event.is_action_pressed("w"):
	#	changeHydration(-10)
	#if event.is_action_pressed("e"):
	#	changeSatiation(-10)
#endregion

#region opening/closing
func openVitals():
	vitalsOpen = not vitalsOpen
	terminal.openTerminal()
	changeHealth(0)
	
func _open_vitals() -> void:
	openVitals()
	
func _on_scavenge_button_open_scav_wind() -> void:
	vitalsOpen = false
func _on_sell_button_open_sell_wind() -> void:
	vitalsOpen = false
func _on_event_log_open_log() -> void:
	vitalsOpen = false
func _on_inventory_button_open_inventory() -> void:
	vitalsOpen = false
func _on_quota_button_open_quota() -> void:
	vitalsOpen = false
func _on_buy_button_open_shop() -> void:
	vitalsOpen = false
func _on_ledger_button_open_ledger() -> void:
	vitalsOpen = false
func _on_skills_button_open_skill_tree() -> void:
	vitalsOpen = false
func _on_digital_clock_open_time() -> void:
	vitalsOpen = false
#endregion
