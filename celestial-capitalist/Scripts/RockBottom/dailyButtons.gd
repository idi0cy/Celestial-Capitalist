extends Node2D

@onready var outerSprite = $outerSprite
@onready var interactable = $interactable
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.35, paddingSize[1] + 0.35)
var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1

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

#func _input(event):
#	if event.is_action_pressed("debug"):
#		writeToTooltip(1, "god")

#whenever a daily money source is enabled call this method
#int amount, string source
func writeToTooltip(amount, source):
	interactable.writeValues(amount, source)
