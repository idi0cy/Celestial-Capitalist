extends Node2D

@onready var upButton = get_node("upButton")
@onready var downButton = get_node("downButton")
@onready var leftButton = get_node("leftButton")
@onready var rightButton = get_node("rightButton")

@onready var normText = load("res://assets/Sprites/RockBottom/minigames/upArrowBox.png")
@onready var upText = load("res://assets/Sprites/RockBottom/minigames/greenArrowBoxHighlighted.png")
@onready var downText = load("res://assets/Sprites/RockBottom/minigames/downArrowBoxHighlighted.png")
@onready var rightText = load("res://assets/Sprites/RockBottom/minigames/rightArrowBoxHighlighted.png")
@onready var leftText = load("res://assets/Sprites/RockBottom/minigames/leftArrowBoxHighlighted.png")
@onready var myParent = get_parent()

var active = false

func _process(_delta):
	if active == true:
		if Input.is_action_just_pressed("up"):
			changeUp()
			myParent.runDeficit()
		if Input.is_action_just_pressed("down"):
			changeDown()
			myParent.runDeficit()
		if Input.is_action_just_pressed("right"):
			changeRight()
			myParent.runDeficit()
		if Input.is_action_just_pressed("left"):
			changeLeft()
			myParent.runDeficit()

func changeUp():
	upButton.texture_normal = upText
	await get_tree().create_timer(0.05).timeout
	upButton.texture_normal = normText

func changeDown():
	downButton.texture_normal = downText
	await get_tree().create_timer(0.05).timeout
	downButton.texture_normal = normText

func changeRight():
	rightButton.texture_normal = rightText
	await get_tree().create_timer(0.05).timeout
	rightButton.texture_normal = normText

func changeLeft():
	leftButton.texture_normal = leftText
	await get_tree().create_timer(0.05).timeout
	leftButton.texture_normal = normText
