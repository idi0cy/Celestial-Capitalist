class_name ConfirmActionButton
extends CCButton
## Confirms the action in the [SellWindow].

@onready var sellWind = get_node("../../../../sellWind")

## The id of the stranger for use in the [member SellWindow.allStrangers] list. Not the index in the [StrangerList].
var personID

## Stores the name of the previously selected action button.
var action = "No Action"

signal confirmAction(theAction, targetID)

func _ready():
	pass
	
func _on_interactable_pressed() -> void:
	#insert the function of this placeholder button here
	confirmAction.emit(action, personID)
	outerSprite.scale = paddingSize
