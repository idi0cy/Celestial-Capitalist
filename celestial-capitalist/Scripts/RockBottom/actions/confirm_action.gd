extends Node

@onready var outerSprite = $outerSprite
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.2, paddingSize[1] + 0.2)
@onready var sellWind = get_node("../../../../sellWind")

#i would export this, but apparently its not necessary
var personIndex

var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1
var action = "No Action"

signal confirmAction(theAction, target)

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
	confirmAction.emit(action, personIndex)
	outerSprite.scale = paddingSize
