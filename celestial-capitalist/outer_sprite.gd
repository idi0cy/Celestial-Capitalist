extends Sprite2D

@export var theScale = scale
@onready var parentNode = $"../../BasicButton"

func _process(_delta):
	scale = parentNode.placeHolder
