extends Node2D

#Item dependent variables list
#Index zero is list, index 1 is quality, index 2 is ...

@onready var invItemScript = load("res://Scripts/RockBottom/InvItem.gd")
@onready var InvGrid = get_node("InvGrid")
@onready var infoBarOne = get_node("infoBarOne")
@onready var itemNameDisplay = get_node("infoBarOne/Item")
@onready var qualDisplay = get_node("infoBarOne/Quality")
@onready var valDisplay = get_node("infoBarOne/Value")

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

#ITEM PROPERTIES STORED HERE SHOULD NEVER BE CHANGED
#They aren't consts because those can't be @onreadied

#Index 0 is item name, 1 is type, 2 is value, 3 is hydration value, 4 is food value for eating
#interpret values with "null" in them as not having that property/value attached to the item

#IMPORTANT NEGATIVE INDICES: Index -1 will be the normal TEXTURE of the item in question
#index -2 will be the shrunken texture of the item


@onready var waterBottle = ["Water Bottle", "Consumable", 2, 50, waterBottleInvIconSmall,
	waterBottleInvIcon]
@onready var pencil = ["Pencil", "Garbage", 1, "null", "null", pencilInvIconSmall, pencilInvIcon]
@onready var burger = ["Burger", "Consumable", 10, 10, 50, hamburIconSmall, hamburIcon]

@onready var allItems = [waterBottle, pencil, burger]

#replace when implimenting save game function (WHYYYYY DO I HAVE TO FIGURE THAT OUT?????)

@onready var currentInv = [[waterBottle, 25], [waterBottle, 50], [waterBottle, 75], [pencil, 10],
[burger, 25], [burger, 50], [burger, 25]]

func _process(_delta):
	if hiding == true:
		self.hide()
	else:
		self.show()

func _on_inventory_button_open_inventory() -> void:
	infoBarOne.itemSelected = false
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
			itemNameDisplay.text = "Item: " + str(itemName)
			qualDisplay.text = "Quality: " + str(itemQual)
			valDisplay.text = "Value: $" + str(itemVal)
			infoBarOne.itemSelected = true

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
