extends Node2D

@onready var outerSprite = $outerSprite
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.35, paddingSize[1] + 0.35)
@onready var pickToSell = get_node("../../pickToSell")

var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1

var selected
var selectedIndex
var hiding = true

signal confirmSelection

func _ready():
	pass

func _process(_delta):
	if hiding == true:
		self.hide()
	else:
		self.show()
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
	hiding = true
	pickToSell.hiding = true
	#print(selectedIndex)
	confirmSelection.emit()
	outerSprite.scale = paddingSize
