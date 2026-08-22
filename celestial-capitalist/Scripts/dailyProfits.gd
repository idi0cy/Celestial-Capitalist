class_name DailyProfits
extends CCButton
## Controls and stores sources of daily profits.

func _ready():
	interactable.writeTooltipTitle("Daily Costs")
	interactable.setContentColour(Color(0.0, 0.645, 0.24, 1.0))

## Takes an amount and a source and formats it for the tooltip
func writeDailyValue(amount:float, source:String):
	interactable.writeTooltipContent("+ $" + str(abs(amount)) + " to " + source + "\n")
