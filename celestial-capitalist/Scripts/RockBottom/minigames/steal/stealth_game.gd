extends Node2D

@onready var playerBar = get_node("playerBar")
@onready var playerBarVisual = get_node("playerBar/playerBarVisual")
@onready var playerArea = get_node("playerBar/PBarea")
@onready var theTarget = get_node("target")
@onready var animation = get_node("goofyAnimation")

var target
var active = false

#this should be at max 383
var barXaxis = 0
var momentum = 0
var reachedTop = false
var reachedBottom = true
var scaleOfBar
var modifier
var succeeding = true
var progress = 15
var maxX = 383
var perfection = true

signal finished(goodOrBad)

func _process(_delta):
	if active == true:
		if progress <= 0:
			failure()
		if progress >= 100:
			success()
		if Input.is_action_pressed("right"):
			if reachedTop == false:
				momentum += 0.2 #also swap this out later
			else:
				momentum = 0
		elif not Input.is_action_pressed("right"):
			if momentum > -7.5:
				momentum -= 0.2 #swap this out with a customized thing later
		if barXaxis <= 0:
			reachedBottom = true
			reachedTop = false
			momentum = abs(momentum / 2)
		elif barXaxis >= maxX:
			if momentum == abs(momentum):
				momentum = 0
			reachedTop = true
			reachedBottom = false
		else:
			reachedTop = false
			reachedBottom = false
		#modify playerBar position code here
		if momentum == abs(momentum):
			if reachedTop == false:
				if barXaxis < maxX:
					barXaxis += momentum
				if barXaxis > maxX:
					barXaxis = maxX
		else:
			if reachedBottom == false:
				barXaxis -= abs(momentum)
		if barXaxis < 0:
			barXaxis = 0
		playerBar.position.x = barXaxis
		if succeeding == true:
			pass
			$progressBar/TextureProgressBar.value += 0.2 * modifier
		else:
			$progressBar/TextureProgressBar.value -= 0.15 / modifier
			perfection = false
		progress = $progressBar/TextureProgressBar.value

func initiate(targetIndex, difficulty): #difficulty is the normal modifier type thing
	perfection = true
	succeeding = true
	$progressBar/TextureProgressBar.value = 25/difficulty
	theTarget.initiate(difficulty)
	modifier = difficulty
	scaleOfBar = 3 * difficulty
	if scaleOfBar < 1:
		playerBarVisual.scale.x = 1
		playerArea.scale.x = 1
		scaleOfBar = 1
	else:
		playerBarVisual.scale.x = scaleOfBar
		playerArea.scale.x = scaleOfBar
	maxX = 383 - ((scaleOfBar - 1) * 41)
	progress = 15
	target = targetIndex
	active = true
	animation.active = true
	animation.show()
	#makeProgress()

func makeProgress():
	await get_tree().create_timer(0.1).timeout
	if active == true:
		if succeeding == true:
			pass
			$progressBar/TextureProgressBar.value += 1
		else:
			$progressBar/TextureProgressBar.value -= 1/modifier
		
		print(progress)
		makeProgress()

func failure():
	#reset all values
	active = false
	$progressBar/TextureProgressBar.value = 15
	succeeding = true
	momentum = 0
	barXaxis = 0
	
	finished.emit("fail")

func success():
	active = false
	$progressBar/TextureProgressBar.value = 15
	succeeding = true
	momentum = 0
	barXaxis = 0
	
	finished.emit("success")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == playerArea:
		succeeding = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == playerArea:
		succeeding = false
