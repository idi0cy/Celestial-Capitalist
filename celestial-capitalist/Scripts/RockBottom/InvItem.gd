extends TextureButton

#SOME COMMENTS TO DISTINGUISH THESE TWO VARIABLES
#assembledItem is a variable for properties that are specific to this item, like quality
#Despite not being specific to this item, the name is included in assembledItem
#look at the index logs for what all the values mean in the inventory script

#Base item will just contain the base values for what the item is
#For example, the value of a water bottle
@export var assembledItem = []
@export var baseItem = []
@export var isPressed = false
