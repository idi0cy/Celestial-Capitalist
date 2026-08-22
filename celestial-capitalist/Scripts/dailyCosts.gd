class_name DailyCosts
extends CCButton
## Controls and stores sources of daily costs.

func _ready():
	interactable.writeTooltipTitle("Daily Costs")
	interactable.setContentColour(Color(1, 0, 0))

## Takes an amount and a source and formats it for the tooltip
func writeDailyValue(amount:float, source:String):
	interactable.writeTooltipContent("- $" + str(abs(amount)) + " to " + source + "\n")
