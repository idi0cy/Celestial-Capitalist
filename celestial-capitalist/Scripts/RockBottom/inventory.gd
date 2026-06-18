extends Node2D

#Item dependent variables list
#Index zero is list, index 1 is quality, index 2 is ...

@onready var invItemScript = load("res://Scripts/RockBottom/InvItem.gd")
@onready var InvGrid = get_node("InvGrid")
@onready var itemDesc = get_node("itemDesc")
@onready var itemNameDisplay = get_node("itemDesc/Item")
@onready var qualDisplay = get_node("itemDesc/infoBarOne/Quality")
@onready var valDisplay = get_node("itemDesc/infoBarOne/Value")
@onready var itemIcon = get_node("itemDesc/itemIcon")
@onready var flavourText = get_node("itemDesc/flavourText")

@onready var waterBottleInvIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/waterInventoryItem.png")
@onready var waterBottleInvIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/waterInvIconSmall.png")
@onready var pencilInvIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/pencilInvSprite.png")
@onready var pencilInvIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/pencilInvIconSmall.png")
@onready var hamburIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/hamburgInvIcon.png")
@onready var hamburIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/Kaydengamesmallhamburger.png")

const quality1 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality1.png")
const quality2 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality2.png")
const quality3 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality3.png")
const quality4 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality4.png")
const quality5 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality5.png")

var count
var count2
var invItem
var hiding = true

#ITEM PROPERTIES STORED HERE SHOULD NEVER BE CHANGED
#They aren't consts because those can't be @onreadied

#Indexes:
#0 is item name,
#1 is type,
#2 is value,
#3 is hydration value,
#4 is food value for eating,
#5 is flavour text
#interpret values with "null" in them as not having that property/value attached to the item

#IMPORTANT NEGATIVE INDICES: Index -1 will be the normal TEXTURE of the item in question
#index -2 will be the shrunken texture of the item

@onready var allItems = []

@onready var waterBottle = newItem("Water Bottle", "Consumable",
	2,
	"null", 50,
	"A bottle of dihydrogen monoxide - very acidic and toxic. Handle with care.",
	waterBottleInvIconSmall, waterBottleInvIcon)
@onready var pencil = newItem("Pencil", "Garbage",
	1,
	"null", "null",
	"You're very hungry and feel like taking a bite. The smell leads you on.",
	pencilInvIconSmall, pencilInvIcon)
@onready var burger = newItem("Burger", "Consumable",
	10,
	10, 50,
	"Too many calories - but simply too enticing... you must...",
	hamburIconSmall, hamburIcon)

func newItem(
	itemName : String, itemType : String,
	cost : int,
	hydrationvalue, consumedvalue,
	flavourtext : String,
	smallTexture : Texture2D, texture : Texture2D):
		var item = [itemName, itemType, cost, hydrationvalue, consumedvalue, flavourtext, smallTexture, texture]
		allItems.append(item)
		return item

#replace when implimenting save game function (WHYYYYY DO I HAVE TO FIGURE THAT OUT?????)

@onready var currentInv = [[waterBottle, 25], [waterBottle, 50], [waterBottle, 75], [pencil, 10],
[burger, 25], [burger, 50], [burger, 25]]

func _process(_delta):
	if hiding == true:
		self.hide()
	else:
		self.show()

func removeItem(index):
	currentInv.remove_at(index)

func _on_inventory_button_open_inventory() -> void:
	itemDesc.itemSelected = false
	count = 0
	for obj in currentInv:
		invItem = TextureButton.new()
		invItem.name = "inv" + str(count)
		invItem.texture_normal = obj[0][-1]
		invItem.texture_pressed = obj[0][-2]
		invItem.set_script(invItemScript)
		invItem.myItem = obj
		invItem.baseItem = obj[0]
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
			itemName = item.myItem[0][0]
			itemQual = item.myItem[1]
			itemVal = item.myItem[1] * item.baseItem[2] * 0.01
			flavourText.text = item.myItem[0][5]
			itemIcon.texture = item.myItem[0][-1]
			itemNameDisplay.text = str(itemName)
			qualDisplay.icon = getStars(itemQual)
			qualDisplay.text = str(itemQual)
			valDisplay.text = str(itemVal)
			itemDesc.itemSelected = true

func getStars(quality : int):
	if (quality > 100):
		return quality5
	elif (quality > 75):
		return quality4
	elif (quality > 50):
		return quality3
	elif (quality > 25):
		return quality2
	else:
		return quality1

func closeIcons():
	for item in InvGrid.get_children():
		InvGrid.remove_child(item)
		item.queue_free()

func _on_scavenge_button_open_scav_wind() -> void:
	closeIcons()
	hiding = true
func _on_sell_button_open_sell_wind() -> void:
	closeIcons()
	hiding = true
func _on_event_log_open_log() -> void:
	closeIcons()
	hiding = true
func _on_ledger_button_open_ledger() -> void:
	closeIcons()
	hiding = true
func _on_quota_button_open_quota() -> void:
	closeIcons()
	hiding = true
func _on_buy_button_open_shop() -> void:
	closeIcons()
	hiding = true
func _on_vitals_button_open_vitals() -> void:
	closeIcons()
	hiding = true
func _on_skills_button_open_skill_tree() -> void:
	closeIcons()
	hiding = true
func _on_digital_clock_open_time() -> void:
	closeIcons()
	hiding = true
