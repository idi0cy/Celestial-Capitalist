extends Node2D

@onready var terminalText = get_node("../../../Terminal/termText")
@onready var rhythmTargetScript = load("res://Scripts/RockBottom/minigames/fakeInjury/rhythm_target.gd")
@onready var targetZone = get_node("targetDomain")
@onready var myParent = get_parent()

var time
var newNote
var random
var random2
var severity
var count
var active
var points = 0

func _process(_delta):
	if active == true:
		count = 0
		for child in targetZone.get_children():
			count += 1
		if count == 0:
			myParent.arbitration(points)
			active = false
			hide()

func initiate(repeats):
	points = 0
	time = 2.0/repeats
	severity = repeats
	show()
	terminalText.targetText = "> System: You know about friday night funkin, right? I'm sure you'll get the hang of it."
	terminalText.fillText()
	await get_tree().create_timer(3).timeout
	
	for i in repeats:
		random2 = randf() * 1.0/(severity/10)
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
		await get_tree().create_timer(random2).timeout
	active = true

func evaluate(distance):
	if distance != 0:
		points += 5 / distance + 10 / severity
	else:
		points += 10 + 10 / severity
