extends Node2D

@onready var outerSprite = $outerSprite
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.25, paddingSize[1] + 0.25)
@onready var interactable = get_node("interactable")
var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1

@export var theTime = 720
signal openTime

func _on_timer_timeout() -> void:
	theTime += 1
	if theTime > 1439:
		theTime = 0
	if theTime > 720:
		if theTime % 60 < 10:
			if (theTime/60) - 12 == 0:
				interactable.text = str(floor(theTime/60)) + ":0" + str(theTime % 60) + " PM"
			else:
				interactable.text = str(floor(theTime/60) -12) + ":0" + str(theTime % 60) + " PM"
		else:
			if (theTime/60) - 12 == 0:
				interactable.text = str(floor(theTime/60)) + ":" + str(theTime % 60) + " PM"
			else:
				interactable.text = str(floor(theTime/60) -12) + ":" + str(theTime % 60) + " PM"
	else:
		if theTime % 60 < 10:
			interactable.text = str(floor(theTime/60)) + ":0" + str(theTime % 60) + " AM"
		else:
			interactable.text = str(floor(theTime/60)) + ":" + str(theTime%60) + " AM"
	print(theTime)

func _ready():
	pass

func _process(_delta):
	if hovering == true:
		placeHolder = outerSprite.scale.lerp(hoverScale, growSpeed)
	else:
		placeHolder = outerSprite.scale.lerp(paddingSize, growSpeed)
	outerSprite.scale = placeHolder

func _on_interactable_mouse_entered() -> void:
	hovering = true

func _on_interactable_mouse_exited() -> void:
	hovering = false

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	openTime.emit()
	outerSprite.scale = paddingSize
