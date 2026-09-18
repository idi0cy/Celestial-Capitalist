extends CCButton

var rerollCost:int = 10

func _ready():
	interactable.tooltipEnabled = true
	interactable.writeTooltipTitle("Let's Go Gambling!")
	interactable.writeTooltipContent(
		"Simple reroll - but be careful!!! Rerolling the market
		will increase the cost of the next reroll by $2!!!!
		Prices reset every in-game day.
		- $" + str(rerollCost))
	super()
