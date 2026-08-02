extends Node

@onready var outerSprite = $outerSprite
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.25, paddingSize[1] + 0.25)

@onready var emptyBox = load("res://assets/Sprites/RockBottom/quotaSprites/emptyChecklist.png")
@onready var checkedBox = load("res://assets/Sprites/RockBottom/quotaSprites/checkedCheckbox.png")

var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.2

signal openCashInquiry

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
	openCashInquiry.emit()
	outerSprite.scale = paddingSize
