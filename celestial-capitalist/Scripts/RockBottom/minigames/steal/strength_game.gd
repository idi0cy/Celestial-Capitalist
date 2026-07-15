extends Node2D

@onready var cloneZone = get_node("cloneZone")
@onready var target = load("res://ButtonScenes/RockBottom/steal_strength_target.tscn")
@onready var targetScript = load("res://Scripts/RockBottom/minigames/steal/strength_target.gd")
@onready var changingText = get_node("changingText")

var difficulty
var iterations = 0
var active = false
var marginAvg
var score = 0
var tarAcc
var totalIterations

var random
var random2

var clone

signal allDone(result)

func _process(_delta):
	if active == true:
		changingText.text = "TARGETS REMAINING: " + str(floor(iterations))

func startCycle():
	if active == true:
		for i in iterations:
			await get_tree().create_timer(1.5 + randf()).timeout
			clone = target.instantiate()
			cloneZone.add_child(clone)
			clone.initiate(difficulty)
			clone.position = Vector2(randi_range(360, 750), randi_range(300,450))
			clone.connect("clicked", targetClicked)
			clone.connect("oldAge", oneDied)

func initiate(difficultyModifier):
	score = 0
	difficulty = difficultyModifier
	marginAvg = 1.5 * difficultyModifier
	iterations = floor(10 / difficultyModifier)
	totalIterations = iterations
	active = true
	startCycle()
	show()

func finished():
	active = false
	random = randf()
	random2 = randf()
	print(random * (score * 1.0 / ((totalIterations * 0.5) + 0.5)))
	print(random2)
	if random * (score * 1.0 / (totalIterations * 0.5)) * (difficulty) > random2:
		allDone.emit("success")
	else:
		allDone.emit("fail")

func targetClicked(accuracy):
	iterations -= 1
	tarAcc = 1 - accuracy
	if tarAcc <= 0.9:
		score += tarAcc
	else:
		score += 1
	if iterations <= 0:
		finished()

func oneDied():
	score -= 0.25
	iterations -= 1
	if iterations <= 0:
		finished()
