extends Sprite2D

var speed = 0
var within = false
var dead = false

func _process(_delta):
	if dead == false:
		position.x -= speed
		if position.x < 10:
			within = true

func initiate(severity, direction):
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
