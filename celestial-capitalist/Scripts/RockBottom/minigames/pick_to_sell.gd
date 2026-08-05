extends Node2D

#Item dependent variables list
#Index zero is list, index 1 is quality, index 2 is ...

@onready var invItemScript = load("res://Scripts/RockBottom/InvItem.gd")
@onready var InvGrid = get_node("scrollContainer/InvGrid")
@onready var itemDesc = get_node("itemDesc")
@onready var flavourText = get_node("itemDesc/flavourText")
@onready var itemIcon = get_node("itemDesc/itemIcon")
@onready var itemNameDisplay = get_node("itemDesc/Item")
@onready var qualDisplay = get_node("itemDesc/infoBarOne/Quality")
@onready var valDisplay = get_node("itemDesc/infoBarOne/Value")
@onready var hydrationDisplay = get_node("itemDesc/infoBarOne/Hydration")
@onready var satiationDisplay = get_node("itemDesc/infoBarOne/Satiation")
@onready var realInventory = get_node("../../../../inventoryWind")
@onready var confirmButton = get_node("confirm")

const quality1 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality1.png")
const quality2 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality2.png")
const quality3 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality3.png")
const quality4 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality4.png")
const quality5 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality5.png")

var count
var count2
var invItem
var hiding = true

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
	itemDesc.itemSelected = false
	
	count = 0
	for obj in currentInv:
		invItem = TextureButton.new()
		invItem.name = "inv" + str(count)
		invItem.texture_normal = obj[0][-1]
		invItem.texture_pressed = obj[0][-2]
		invItem.set_script(invItemScript)
		invItem.assembledItem = obj
		invItem.baseItem = obj[0]
		invItem.pressed.connect(generateInfo.bind(count))
		InvGrid.add_child(invItem)
		count += 1
	
	#if hiding == false:
		#closeIcons()
	hiding = false

func generateInfo(index):
	count2 = -1
	var itemVal
	var itemQual
	var itemHydration
	var itemSatiation
	for item in InvGrid.get_children():
		count2 += 1
		if count2 == index:
			itemQual = item.assembledItem[1]
			itemVal = item.assembledItem[3]
			itemHydration = item.assembledItem[4]
			itemSatiation = item.assembledItem[5]
			
			flavourText.text = item.assembledItem[0][5]
			itemIcon.texture = item.assembledItem[0][-1]
			itemNameDisplay.text = item.assembledItem[2]
			qualDisplay.icon = getStars(itemQual)
			qualDisplay.text = str(itemQual) + "/100"
			valDisplay.text = str(itemVal)
			hydrationDisplay.text = str(itemHydration)
			satiationDisplay.text = str(itemSatiation)
			
			itemDesc.itemSelected = true
			confirmButton.selectedIndex = count2
			confirmButton.selected = item
			confirmButton.hiding = false

func getStars(quality : int):
	if (quality > 80):
		return quality5
	elif (quality > 60):
		return quality4
	elif (quality > 40):
		return quality3
	elif (quality > 20):
		return quality2
	else:
		return quality1

func closeIcons():
	for item in InvGrid.get_children():
		InvGrid.remove_child(item)
		item.queue_free()
