extends Sprite2D

var speed = 0
var within = false
var dead = 0
var perfectX = 379
var deadX = 357
var myDirection
signal signalDead
signal imPressed(dist)

#MANY ISSUES STARTING WITH SCALE

func _process(_delta):
	print(scale)
	if dead == 0:
		scale.lerp(Vector2(1, 1), 10)
		position.x -= speed
		if position.x < 10:
			within = true
	elif dead == 1:
		scale.lerp(Vector2(0.01, 0.01), 5)
		modulate.a -= 5
	elif dead == 2:
		scale.lerp(Vector2(2,2), 15)
		modulate.a -= 20
	if position.x < 357:
		dead = 1
	if modulate.a < 10 and dead == 1:
		signalDead.emit()
		get_parent().remove_child(self)
		queue_free()
	elif modulate.a < 10 and dead == 2:
		imPressed.emit(abs(perfectX - position.x))
		get_parent().remove_child(self)
		queue_free()
	
	if Input.is_action_just_pressed(myDirection):
		if position.x < 400:
			dead = 2

func initiate(severity, direction):
	myDirection = direction
	speed = severity/20
	if direction == "up":
		texture = load("res://assets/Sprites/RockBottom/minigames/upArrowBox.png")
		rotation = 0.0
		position = Vector2(756, 262)
	elif direction == "down":
		texture = load("res://assets/Sprites/RockBottom/minigames/downArrowBox.png")
		rotation = 180.0
		position = Vector2(756, 290)
	elif direction == "left":
		texture = load("res://assets/Sprites/RockBottom/minigames/leftArrowBox.png")
		rotation = 90.0
		position = Vector2(756, 318)
	elif direction == "right":
		texture = load("res://assets/Sprites/RockBottom/minigames/rightArrowBox.png")
		rotation = 270.0
		position = Vector2(756, 346)
	scale = Vector2(0.1, 0.1)
