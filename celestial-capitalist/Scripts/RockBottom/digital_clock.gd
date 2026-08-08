class_name Clock
extends CCButton
## The global in game clock.
##
## Increments by one minute every 2 seconds.

## The time. Why is it 'the' time? Who knows?
var theTime = 720

## Open the yet to be made clock screen.
signal openTime
## Called when the time changes, every 2 seconds.
signal onTimeChanged

## Called every 2 seconds. Updates [member theTime] and the clock button's text.
func _on_timer_timeout() -> void:
	theTime += 1
	if theTime > 1439:
		theTime = 0
	if theTime > 720:
		if theTime % 60 < 10:
			@warning_ignore("integer_division")
			if (theTime/60) - 12 == 0:
				@warning_ignore("integer_division")
				interactable.text = str(floor(theTime/60)) + ":0" + str(theTime % 60) + " PM"
			else:
				@warning_ignore("integer_division")
				interactable.text = str(floor(theTime/60) -12) + ":0" + str(theTime % 60) + " PM"
		else:
			@warning_ignore("integer_division")
			if (theTime/60) - 12 == 0:
				@warning_ignore("integer_division")
				interactable.text = str(floor(theTime/60)) + ":" + str(theTime % 60) + " PM"
			else:
				@warning_ignore("integer_division")
				interactable.text = str(floor(theTime/60) -12) + ":" + str(theTime % 60) + " PM"
	else:
		if theTime % 60 < 10:
			@warning_ignore("integer_division")
			interactable.text = str(floor(theTime/60)) + ":0" + str(theTime % 60) + " AM"
		else:
			@warning_ignore("integer_division")
			interactable.text = str(floor(theTime/60)) + ":" + str(theTime%60) + " AM"
	onTimeChanged.emit()

func _ready():
	pass

func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	openTime.emit()
	outerSprite.scale = paddingSize
	
#func _input(event):
#	if event.is_action_pressed("debug"):
#		theTime += 60
