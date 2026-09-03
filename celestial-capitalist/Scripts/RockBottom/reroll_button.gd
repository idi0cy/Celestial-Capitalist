extends CCButton

func _ready():
	interactable.writeTooltipTitle("Rerolling will incur:")
	interactable.writeTooltipContent("- $50 \nModifiers: ")
	super()
