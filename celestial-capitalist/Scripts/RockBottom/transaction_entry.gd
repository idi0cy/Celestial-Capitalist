extends Control

@onready var outerSprite = $outerSprite
@onready var interactable = $interactable
@onready var expandedWindow = $expandedWindow
@onready var soldbought = $expandedWindow/soldBought
@onready var fromto = $expandedWindow/fromTo
@onready var itemSprite = $expandedWindow/itemSprite
@onready var paddingSize = outerSprite.theScale
@onready var hoverScale = Vector2(paddingSize[0] + 0.35, paddingSize[1] + 0.35)
var placeHolder = Vector2(0,0)
var hovering = false
var growSpeed = 0.1
var windowExpanded = false

func _ready():
	pass
	
func _process(_delta):
	if hovering == true:
		placeHolder = outerSprite.scale.lerp(hoverScale, growSpeed)
	else:
		placeHolder = outerSprite.scale.lerp(paddingSize, growSpeed)
	outerSprite.scale = placeHolder
	
	if windowExpanded == false:
		expandedWindow.hide()
		self.custom_minimum_size = Vector2(267, 67)
	else:
		expandedWindow.show()
		self.custom_minimum_size = Vector2(267, 179)

# int amount, int time, string party, string subject, texture2d texture
func writeTransaction(amount, time, party, subject, texture):
	var posNegIcon : Texture2D
	if (amount > 0):
		posNegIcon = load("res://assets/Sprites/RockBottom/buttonIcons/dailyProfits.png")
	else:
		posNegIcon = load("res://assets/Sprites/RockBottom/buttonIcons/dailyCosts.png")
	interactable.icon = posNegIcon
	@warning_ignore("integer_division")
	var hours : int = (floori(float(time) / 60))
	var minutes : int = time - hours * 60
	var convertedMinutes : String
	var convertedHours: String
	if (str(minutes).length() == 1):
		convertedMinutes = "0" + str(minutes)
	else:
		convertedMinutes = str(minutes)
	if (str(hours).length() == 1):
		convertedHours = "0" + str(hours)
	else:
		convertedHours = str(hours)
	var convertedTime : String = convertedHours + ":" + convertedMinutes
	interactable.text = "$" + str(abs(amount)) + "| " + convertedTime
	
	itemSprite.texture = texture
	
	if(amount > 0):
		if (subject == "Donated"):
			soldbought.text = subject
		elif (subject == "Blackmail"):
			soldbought.text = subject
		elif (subject == "Scammed"):
			soldbought.text = subject
		elif (subject == "Redeemed"):
			soldbought.text = subject
		else:
			soldbought.text = "Sold: " + subject
	else:
		soldbought.text = "Bought: " + subject
		
	if(amount > 0):
		fromto.text = "From: " + party
	else:
		fromto.text = "To: " + party

func _on_interactable_mouse_entered() -> void:
	hovering = true

func _on_interactable_mouse_exited() -> void:
	hovering = false

func _on_interactable_pressed() -> void:
	windowExpanded = not windowExpanded
	outerSprite.scale = paddingSize
