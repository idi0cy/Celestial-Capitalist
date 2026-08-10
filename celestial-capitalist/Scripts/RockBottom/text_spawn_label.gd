class_name CCLabel
extends Label
## Label that quickly types its text character by character. 
##
## Modify [member targetText] to set the text, then call [method fillText] to animate it. Directly change [member text] to override the animation.

## What the animation should type to.
var targetText = ""
## Stores whether the animation is done and matches [member targetText].
var textDone = false

func _process(_delta):
	if text == targetText:
		textDone = true
	else:
		textDone = false

## Animate the text character by character.
func fillText():
	text = ""
	for i in len(targetText) + 1:
		text = targetText.substr(0,i)
		await get_tree().create_timer(0.01).timeout
