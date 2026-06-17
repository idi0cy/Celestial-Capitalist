extends Sprite2D

var speed = 0
var within = false
var dead = 0
var perfectX = 379
var deadX = 357
var myDirection
var targetScale = Vector2(1, 1)
var stopIt = false
var stopIt2 = false
var activateColour
signal signalDead
signal imPressed(dist)

#MANY ISSUES STARTING WITH SCALE

func _process(_delta):
	if dead == 0:
		scale = scale.lerp(targetScale, 0.1)
		position.x -= speed
		if position.x < 10:
			within = true
	elif dead == 1:
		scale = scale.lerp(Vector2(0.01, 0.01), 0.05)
		if stopIt == false:
			deathAnimation()
	elif dead == 2:
		scale = scale.lerp(Vector2(3,3), 0.1)
		if stopIt2 == false:
			gotItAnimation()
	if position.x < 357:
		dead = 1
	if modulate.a <= 0.1 and dead == 1:
		#get_parent().remove_child(self)
		queue_free()
	elif modulate.a <= 0.0 and dead == 2:
		imPressed.emit(abs(perfectX - position.x))
		#get_parent().remove_child(self)
		queue_free()
	
	if Input.is_action_just_pressed(myDirection):
		if position.x < 400:
			dead = 2

func initiate(severity, direction):
	stopIt = false
	stopIt2 = false
	dead = 0
	myDirection = direction
	speed = severity/25.0
	if speed < 0.5:
		speed = 0.5
	if direction == "up":
		texture = load("res://assets/Sprites/RockBottom/minigames/upArrowNote.png")
		activateColour = Color(0.0, 1.0, 0.0, 1.0)
		rotation_degrees = 0.0
		position = Vector2(756, 262)
	elif direction == "down":
		texture = load("res://assets/Sprites/RockBottom/minigames/downArrowBox.png")
		activateColour = Color(1.0, 0.0, 0.0, 1.0)
		rotation_degrees = 180.0
		position = Vector2(756, 290)
	elif direction == "left":
		texture = load("res://assets/Sprites/RockBottom/minigames/leftArrowBox.png")
		activateColour = Color(0.0, 0.0, 1.0, 1.0)
		rotation_degrees = 270.0
		position = Vector2(756, 318)
	elif direction == "right":
		texture = load("res://assets/Sprites/RockBottom/minigames/rightArrowBox.png")
		activateColour = Color(0.929, 0.91, 0.0, 1.0)
		rotation_degrees = 90.0
		position = Vector2(756, 346)
	scale = Vector2(0.1, 0.1)

func gotItAnimation():
	stopIt2 = true
	for i in 25:
		await get_tree().create_timer(0.01).timeout
		modulate.a -= 0.04

func deathAnimation():
	signalDead.emit()
	stopIt = true
	for i in 50:
		await get_tree().create_timer(0.01).timeout
		modulate.a -= 0.02
