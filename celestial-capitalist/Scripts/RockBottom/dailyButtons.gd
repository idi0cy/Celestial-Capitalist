class_name DailyMonetaryButton
extends CCButton
## Displays daily income/expense. Also controls their storage.

func _ready():
	pass

## Call to write a daily monetary factor to the tooltip.
func writeToTooltip(amount, source):
	interactable.writeValues(amount, source)
