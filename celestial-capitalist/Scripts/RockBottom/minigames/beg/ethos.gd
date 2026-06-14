extends Node

@onready var outerSprite = $outerSprite
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.35, paddingSize[1] + 0.35)
@onready var terminalText = get_node("../../../../Terminal/termText")

var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1

signal ethos

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
	terminalText.targetText = "> System: Use your esteemed authority as a homeless person to convince this stranger to donate to you."
	terminalText.fillText()
	ethos.emit()
	outerSprite.scale = paddingSize
