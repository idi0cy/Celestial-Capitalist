class_name Clock
extends CCButton
## The global in game clock.
##
## Increments by one minute every 2 seconds.

## The time. Why is it 'the' time? Who knows?
var theTime = 720
## Float. Contains decimals to operate on intervals of 0.1 seconds.
var trueTime:float = 720

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
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Game Time")
	interactable.writeTooltipContent(
		"Progresses one in-game minute every
		two IRL seconds. Over time, your vitals
		will go down, strangers, loot, and the
		market will refresh, and random events
		will happen.")

func _on_interactable_pressed() -> void:
	outerSprite.scale = paddingSize
	
#func _input(event):
#	if event.is_action_pressed("debug"):
#		theTime += 60

func _on_true_time_timeout() -> void:
	trueTime = snapped(trueTime + 0.1, 0.1)
