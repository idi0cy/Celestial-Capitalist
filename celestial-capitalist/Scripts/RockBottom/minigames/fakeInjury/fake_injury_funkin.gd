extends Node2D

@onready var terminalText = get_node("../../../Terminal/termText")
@onready var rhythmTargetScript = load("res://Scripts/RockBottom/minigames/fakeInjury/rhythm_target.gd")
@onready var targetZone = get_node("targetDomain")
@onready var buttons = get_node("buttons")
@onready var myParent = get_parent()

var time
var newNote
var random
var random2
var severity
var count
var active = false
var points = 0

func _process(_delta):
	if active == true:
		if targetZone.get_child_count() == 0:
			active = false
			buttons.active = false
			await get_tree().create_timer(1).timeout
			myParent.arbitration(points)
			hide()

func initiate(repeats):
	buttons.active = true
	active = false
	points = 0
	time = 2.0/repeats
	severity = repeats
	show()
	terminalText.targetText = "> System: You know about friday night funkin, right? I'm sure you'll get the hang of it."
	terminalText.fillText()
	await get_tree().create_timer(3).timeout
	
	if repeats < 10:
		severity = 10
	for i in severity:
		random2 = randf() * 5.0/(severity/10.0)
		random = randi_range(0,3)
		newNote = Sprite2D.new()
		newNote.set_script(rhythmTargetScript)
		targetZone.add_child(newNote)
		if random == 0:
			newNote.initiate(severity, "up")
		elif random == 1:
			newNote.initiate(severity, "down")
		elif random == 2:
			newNote.initiate(severity, "left")
		elif random == 3:
			newNote.initiate(severity, "right")
		newNote.imPressed.connect(evaluate)
		newNote.signalDead.connect(wompWomp)
		await get_tree().create_timer(random2).timeout
	active = true

func wompWomp():
	points -= 5 * (severity * 0.01)

func runDeficit():
	points -= 2

func evaluate(distance):
	if distance != 0:
		points += (5 / distance + severity/10)
	else:
		points += 25 + 10 / severity
	points = floor(points)
