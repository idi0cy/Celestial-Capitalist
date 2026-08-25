extends CCButton

func _ready():
	interactable.writeTooltipTitle("Reroll")
	interactable.writeTooltipContent("Cost: $50 \nModifiers: ")
	super()
