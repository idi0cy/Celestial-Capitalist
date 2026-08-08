class_name UntilNewStrangers
extends ProgressBar
## Counts and displays time until next stranger refresh.

@onready var clock = get_node("../../../../digitalClock")

signal refresh(theValue)

func _ready():
	value = 0
	pass

## Update the progress bar and send updates to [SellWindow]
func _on_digital_clock_on_time_changed() -> void:
	value = clock.theTime % 30
	refresh.emit(value)
