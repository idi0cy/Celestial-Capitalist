extends Node2D

#Item dependent variables list
#Index zero is list, index 1 is quality, index 2 is ...

@onready var invItemScript = load("res://Scripts/RockBottom/InvItem.gd")
@onready var InvGrid = get_node("InvGrid")
@onready var infoBarOne = get_node("infoBarOne")
@onready var itemNameDisplay = get_node("infoBarOne/Item")
@onready var qualDisplay = get_node("infoBarOne/Quality")
@onready var valDisplay = get_node("infoBarOne/Value")
@onready var realInventory = get_node("../../../../inventoryWind")

@onready var waterBottleInvIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/waterInventoryItem.png")
@onready var waterBottleInvIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/waterInvIconSmall.png")
@onready var pencilInvIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/pencilInvSprite.png")
@onready var pencilInvIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/pencilInvIconSmall.png")
@onready var hamburIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/hamburgInvIcon.png")
@onready var hamburIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/Kaydengamesmallhamburger.png")

var count
var count2
var invItem
var hiding = true

#Index 0 is item name, 1 is type, 2 is value, 3 is hydration value, 4 is food value for eating
#interpret values with "null" in them as not having that property/value attached to the item
const waterBottle = ["Water Bottle", "Consumable", 2, 50]
const pencil = ["Pencil", "Garbage", 1, "null", "null"]
const burger = ["Burger", "Consumable", 10, 10, 50]
const allItems = ["Water Bottle", "Pencil", "Burger"]

#replace when implimenting save game function (WHYYYYY DO I HAVE TO FIGURE THAT OUT?????)
var currentInv

func _process(_delta):
	currentInv = realInventory.currentInv
	if hiding == true:
		self.hide()
	else:
		self.show()

#CHANGE THIS THINGY TO BE NOT THE INV BUTTON
func openPickToSell():
	infoBarOne.itemSelected = false
	count = 0
	for item in currentInv:
		if item[0] == "Water Bottle":
			#run code for making a new texture button in the grid that has the properties of item
			invItem = TextureButton.new()
			invItem.texture_normal = waterBottleInvIcon
			invItem.texture_pressed = waterBottleInvIconSmall
			invItem.name = "inv" + str(count)
			invItem.set_script(invItemScript)
			invItem.myItem = item
			invItem.baseItem = waterBottle
			invItem.pressed.connect(generateInfo.bind(count))
			invItem.myItem = item
			InvGrid.add_child(invItem)
		if item[0] == "Pencil":
			invItem = TextureButton.new()
			invItem.texture_normal = pencilInvIcon
			invItem.texture_pressed = pencilInvIconSmall
			invItem.name = "inv" + str(count)
			invItem.set_script(invItemScript)
			invItem.myItem = item
			invItem.baseItem = pencil
			invItem.pressed.connect(generateInfo.bind(count))
			InvGrid.add_child(invItem)
		if item[0] == "Burger":
			invItem = TextureButton.new()
			invItem.texture_normal = hamburIcon
			invItem.texture_pressed = hamburIconSmall
			invItem.name = "inv" + str(count)
			invItem.set_script(invItemScript)
			invItem.myItem = item
			invItem.baseItem = burger
			invItem.pressed.connect(generateInfo.bind(count))
			InvGrid.add_child(invItem)
		count += 1
	if hiding == false:
		closeIcons()
	hiding = not hiding

func generateInfo(index):
	count2 = -1
	var itemName
	var itemVal
	var itemQual
	for item in InvGrid.get_children():
		count2 += 1
		if count2 == index:
			itemName = item.myItem[0]
			itemQual = item.myItem[1]
			itemVal = item.myItem[1] * item.baseItem[2] * 0.01
			itemNameDisplay.text = "Item: " + str(itemName)
			qualDisplay.text = "Quality: " + str(itemQual)
			valDisplay.text = "Value: $" + str(itemVal)
			infoBarOne.itemSelected = true

func closeIcons():
	for item in InvGrid.get_children():
		InvGrid.remove_child(item)
		item.queue_free()
