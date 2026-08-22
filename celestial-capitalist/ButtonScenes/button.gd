class_name CCButton
extends Resources
## A template for buttons.
## 
## Special buttons, AKA buttons that do not instance the button template scene and have their own script, should override the [method Node._ready]
## method and replace the contents with [code]pass[/code]. Otherwise, the button will be blank as the template scene is not used and can't set the icon or text.
## Special buttons should be used if you want special behaviour beyond lerping and sending the signal. [br]
## [br]
## Tooltips can be added by overriding ready and calling tooltip methods on [member interactable]. See [class Interactable] for details. [br]
## [br]
## Buttons that do use the template scene only need to instance the scene and set the icon and texture in the inspector, then connect the signal.

## References the background texture of the button.
@onready var outerSprite = $outerSprite
## References the actual clickable part of the button/the [Interactable] node.
@onready var interactable = $interactable

@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.35, paddingSize[1] + 0.35)

@export var icon:Texture2D
@export var text:String

var placeHolder = Vector2(0,0)
## Specifies whether it's hovered over or not.
var hovering = false
## Speed that the button grows/shrinks at.
var growSpeed = 0.1

signal buttonPressed

func _ready():
	interactable.icon = icon
	interactable.text = text

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
	buttonPressed.emit()
	outerSprite.scale = paddingSize
