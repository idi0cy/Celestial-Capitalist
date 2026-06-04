extends Node2D

@onready var outerSprite = $outerSprite
@onready var interactable = $interactable
@onready var enterDelay = get_node("../Timers/menuDelay1")
@onready var paddingSize = Vector2(7.543, 1.492)
@onready var hoverScale = Vector2(paddingSize[0] + 0.5, paddingSize[1] + 0.5)
var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1
var moveSpeed = 2.0
var movement = false

func _ready():
	interactable.text = "Start Game"
	enterDelay.start()

func _process(delta):
	if hovering == true:
		placeHolder = outerSprite.scale.lerp(hoverScale, growSpeed)
	else:
		placeHolder = outerSprite.scale.lerp(paddingSize, growSpeed)
	if movement == true:
		position = position.lerp(Vector2(1000,375), delta*moveSpeed)
	outerSprite.scale = placeHolder

func _on_interactable_mouse_entered() -> void:
	hovering = true

func _on_interactable_mouse_exited() -> void:
	hovering = false

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	print(self)

func _on_menu_delay_1_timeout() -> void:
	movement = true
