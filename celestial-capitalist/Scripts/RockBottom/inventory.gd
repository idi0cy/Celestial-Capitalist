extends Node2D

func refreshInventory():
	itemDesc.itemSelected = false
	itemSelected = false
	selectedAssembledItem = []
	count = 0
	for child in InvGrid.get_children():
		InvGrid.remove_child(child)
		child.queue_free()
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

#region variables
@onready var invItemScript = load("res://Scripts/RockBottom/InvItem.gd")
@onready var InvGrid = get_node("scrollContainer/InvGrid")
@onready var itemDesc = get_node("itemDesc")
@onready var itemNameDisplay = get_node("itemDesc/Item")
@onready var qualDisplay = get_node("itemDesc/infoBarOne/Quality")
@onready var valDisplay = get_node("itemDesc/infoBarOne/Value")
@onready var hydrationDisplay = get_node("itemDesc/infoBarOne/Hydration")
@onready var satiationDisplay = get_node("itemDesc/infoBarOne/Satiation")
@onready var itemIcon = get_node("itemDesc/itemIcon")
@onready var flavourText = get_node("itemDesc/flavourText")
@onready var terminal = get_node("../terminal")
@onready var terminalText = get_node("../terminal/termText")
@onready var vitals = get_node("../vitals")
@onready var ledger = get_node("../Ledger")
@onready var clock = get_node("../../digitalClock")

const quality1 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality1.png")
const quality2 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality2.png")
const quality3 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality3.png")
const quality4 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality4.png")
const quality5 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality5.png")

var count
var count2
var invItem
var maxInvSize = 20
var hiding = true
var itemSelected = false
var selectedAssembledItem:Array
var selectedItemIndex

@onready var allItems = []
#endregion

#region item default data
#CRITICAL ITEM PROPERTIES STORED HERE SHOULD NEVER BE CHANGED
#They aren't consts because those can't be @onreadied

@onready var waterBottleInvIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/waterInventoryItem.png")
@onready var waterBottleInvIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/waterInvIconSmall.png")
@onready var pencilInvIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/pencilInvSprite.png")
@onready var pencilInvIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/pencilInvIconSmall.png")
@onready var hamburIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/hamburgInvIcon.png")
@onready var hamburIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/Kaydengamesmallhamburger.png")
@onready var applianceIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/appliance.png")
@onready var applianceIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/applianceSmall.png")
@onready var penIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/pen.png")
@onready var penIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/penSmall.png")
@onready var sodaCanIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/sodaCan.png")
@onready var sodaCanIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/sodaCanSmall.png")
@onready var vegetablesIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/vegetables.png")
@onready var vegetablesIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/vegetablesSmall.png")
@onready var meatsIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/meats.png")
@onready var meatsIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/meatsSmall.png")
@onready var cheeseIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/cheese.png")
@onready var cheeseIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/cheeseSmall.png")
@onready var phoneIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/phone.png")
@onready var phoneIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/phoneSmall.png")
@onready var cardboardIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/cardboard.png")
@onready var cardboardIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/cardboardSmall.png")
@onready var soySauceIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/soySauce.png")
@onready var soySauceIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/soySauceSmall.png")
@onready var bagIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/bag.png")
@onready var bagIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/bagSmall.png")
@onready var headphonesIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/headphones.png")
@onready var headphonesIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/headphonesSmall.png")
@onready var paperIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/paper.png")
@onready var paperIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/paperSmall.png")
@onready var toiletPaperIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/toiletPaper.png")
@onready var toiletPaperIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/toiletPaperSmall.png")
@onready var ponderIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/ponder.png")
@onready var ponderIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/ponderSmall.png")
@onready var skincareIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/skincare.png")
@onready var skincareIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/skincareSmall.png")
@onready var computerIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/computer.png")
@onready var computerIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/computerSmall.png")
@onready var catIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/cat.png")
@onready var catIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/catSmall.png")
@onready var briefcaseIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/briefcase.png")
@onready var briefcaseIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/briefcaseSmall.png")
@onready var coinIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/coin.png")
@onready var coinIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/coinSmall.png")
@onready var billIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/bill.png")
@onready var billIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/billSmall.png")
@onready var chequeIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/cheque.png")
@onready var chequeIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/chequeSmall.png")
@onready var bondIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/bond.png")
@onready var bondIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/bondSmall.png")

@onready var shirtIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/shirt.png")
@onready var shirtIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/shirtSmall.png")
@onready var sunglassesIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/sunglasses.png")
@onready var sunglassesIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/sunglassesSmall.png")
@onready var hatIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/hat.png")
@onready var hatIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/hatSmall.png")
@onready var pantsIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/pants.png")
@onready var pantsIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/pantsSmall.png")
@onready var shortsIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/shorts.png")
@onready var shortsIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/shortsSmall.png")
@onready var hoodieIcon = load("res://assets/Sprites/RockBottom/inventoryIcons/hoodie.png")
@onready var hoodieIconSmall = load("res://assets/Sprites/RockBottom/inventoryIcons/hoodieSmall.png")

@onready var waterBottle = newItem("Water Bottle", "Consumable",
	8,
	50, "null",
	"A bottle of dihydrogen monoxide - very acidic and toxic. Handle with care.",
	waterBottleInvIconSmall, waterBottleInvIcon)
@onready var pencil = newItem("Pencil", "Object",
	5,
	"null", "null",
	"You're very hungry and feel like taking a bite. The smell leads you on.",
	pencilInvIconSmall, pencilInvIcon)
@onready var burger = newItem("Burger", "Consumable",
	20,
	5, 25,
	"Too many calories - but simply too enticing... you must...",
	hamburIconSmall, hamburIcon)
@onready var appliance = newItem("Appliance", "Object",
	125,
	"null", "null",
	"A machine of sorts. You haven't been in a kitchen for a while - you don't even recognize it...",
	applianceIconSmall, applianceIcon)
@onready var pen = newItem("Pen", "Object",
	20,
	"null", "null",
	"It's almost out of ink. Tragic!",
	penIconSmall, penIcon)
@onready var sodaCan = newItem("Soda Can", "Consumable",
	15,
	"null", 50,
	"Poke or Cepsi?",
	sodaCanIconSmall, sodaCanIcon)
@onready var vegetables = newItem("Assorted Vegetables", "Consumable",
	60,
	30, 30,
	"Store bought. You wrinkle your nose in hypocritical disgust.",
	vegetablesIconSmall, vegetablesIcon)
@onready var meats = newItem("Assorted Meats", "Consumable",
	80,
	"null", 50,
	"Grass fed beef!",
	meatsIconSmall, meatsIcon)
@onready var cheese = newItem("Cheese", "Consumable",
	40,
	"null", 10,
	"I could put a cheesy joke here, but I'm feeling discheesed today.",
	cheeseIconSmall, cheeseIcon)
@onready var phone = newItem("Phone", "Object",
	300,
	"null", "null",
	"You try to open it. Face ID stares blankly.",
	phoneIconSmall, phoneIcon)
@onready var cardboard = newItem("Cardboard", "Consumable",
	10,
	"null", 5,
	"You're cardly hungry. You're not hungry. You're not. Don't eat it.",
	cardboardIconSmall, cardboardIcon)
@onready var soySauce = newItem("Soy Sauce", "Consumable",
	45,
	30, "null",
	"The lifeblood of the universe!",
	soySauceIconSmall, soySauceIcon)
@onready var bag = newItem("Bag", "Object",
	50,
	"null", "null",
	"You don't know enough about bags to decide whether this is a fancy one.",
	bagIconSmall, bagIcon)
@onready var headphones = newItem("Headphones", "OBject",
	100,
	"null", "null",
	"You put them on and hear a strange rumbling from your abdomen. They work!",
	headphonesIconSmall, headphonesIcon)
@onready var paper = newItem("Paper", "Consumable",
	20,
	"null", 2,
	"It's just compressed plants, right?! Surely you can eat this!",
	paperIconSmall, paperIcon)
@onready var hoodie = newItem("Hoodie", "Clothing",
	40,
	"null", "null",
	"Warm... soft... or maybe you're just hypothermic...",
	hoodieIconSmall, hoodieIcon)
@onready var shirt = newItem("Shirt", "Clothing",
	50,
	"null", "null",
	"It's a plain t-shirt. A white void...",
	shirtIconSmall, shirtIcon)
@onready var pants = newItem("Pants", "Clothing",
	50,
	"null", "null",
	"Neither thick enough nor thin enough. Uncomfortable.",
	pantsIconSmall, pantsIcon)
@onready var sunglasses = newItem("Sunglasses", "Clothing",
	50,
	"null", "null",
	"The smog blocks the sun either way. Sunglasses are falling out of favour these days.",
	sunglassesIconSmall, sunglassesIcon)
@onready var hat = newItem("Hat", "Clothing",
	30,
	"null", "null",
	"It's a hat... and I don't know what else to say here... if it's only this one that's 4th walling it's fine...",
	hatIconSmall, hatIcon)
@onready var shorts = newItem("Shorts", "Clothing",
	40,
	"null", "null",
	"They seem kind of long for shorts?",
	shortsIconSmall, shortsIcon)
@onready var toiletPaper = newItem("Toilet Paper", "Object",
	30,
	"null", 2,
	"The fortune this would have gone for a few years ago... but that's over now.",
	toiletPaperIconSmall, toiletPaperIcon)
@onready var ponder = newItem("Suspiciously Sharp Rabbit Puppet", "Object",
	700,
	"null", "null",
	"You ponder it's presence here. It's teeth are very sharp...",
	ponderIconSmall, ponderIcon)
@onready var skincare = newItem("Skincare Product", "Consumable",
	60,
	2, "null",
	"You really shouldn't eat it. But, colourful = tasty, right?!",
	skincareIconSmall, skincareIcon)
@onready var computer = newItem("PC", "Object",
	400,
	"null", "null",
	"What a find! You quietly pluck the ram sticks out of it. The buyers won't notice.",
	computerIconSmall, computerIcon)
@onready var cat = newItem("Cat", "Consumable",
	300,
	"null", 50,
	"It meows at you. You resist the urge to begin chowing down.",
	catIconSmall, catIcon)
@onready var briefcase = newItem("Briefcase", "Object",
	50,
	"null", "null",
	"You briefly glance at it, then move on to more interesting things.",
	briefcaseIconSmall, briefcaseIcon)
@onready var coin = newItem("Coin", "Currency",
	2,
	"null", "null",
	"Redeems up to 2 dollars.",
	coinIconSmall, coinIcon)
@onready var bill = newItem("Bill", "Currency",
	20,
	"null", "null",
	"Redeems up to 20 dollars.",
	billIconSmall, billIcon)
@onready var cheque = newItem("Cheque", "Currency",
	100,
	"null", "null",
	"Redeems up to 100 dollars.",
	chequeIconSmall, chequeIcon)
@onready var bond = newItem("Bond", "Currency",
	400,
	"null", "null",
	"Redeems up too 100-400 dollars.",
	bondIconSmall, bondIcon)
#endregion

@onready var currentInv = [
	assembleItem(25, waterBottle), assembleItem(50, waterBottle), 
	assembleItem(75, waterBottle), assembleItem(10, pencil),
	assembleItem(25, burger), assembleItem(50, burger),
	assembleItem(50, burger)
]

#region item helper methods

#WARNING | A base item is the item's default instance. An assembled item is a modified base item.
#Inventories accept assembled items, not base items.

#Base Item Indexes:
#0 is item name,
#1 is type,
#2 is max value,
#3 is hydration value,
#4 is food value for eating,
#5 is flavour text
#interpret values with "null" in them as not having that property/value attached to the item

#IMPORTANT NEGATIVE INDICES: Index -1 will be the normal TEXTURE of the item in question
#index -2 will be the shrunken texture of the item

func newItem(
	itemName : String, itemType : String,
	maxValue : int,
	hydrationvalue, consumedvalue,
	flavourtext : String,
	smallTexture : Texture2D, texture : Texture2D):
		var item = [itemName, itemType, maxValue, hydrationvalue, consumedvalue, flavourtext, smallTexture, texture]
		allItems.append(item)
		return item

# Assembled Item Indexes:
# 0 is the base item
# 1 is the quality, which the last three are calculated from
# 2 is the display name - generated, easter egg, etc.
# 3 is the value
# 4 is hydration
# 5 is satiation

func assembleItem(quality : int, baseItem : Array, displayName : String = baseItem[0]):
	var itemVal = snapped((quality * baseItem[2] * 0.01), 0.01)
	var hydration = 0
	var satiation = 0
	if baseItem[3] is int:
		hydration = snapped((quality * baseItem[3] * 0.01), 1)
	if baseItem[4] is int:
		satiation = snapped((quality * baseItem[4] * 0.01), 1)
	return [baseItem, quality, displayName, itemVal, hydration, satiation]

#adding items should always use this method - this can let us check for inventory fullness
func addItem(assembledItem):
	currentInv.append(assembledItem)
	
func removeItem(index):
	currentInv.remove_at(index)
#endregion

#region screen opening/closing
func _process(_delta):
	if hiding == true:
		self.hide()
	else:
		self.show()

func _on_inventory_button_open_inventory() -> void:
	refreshInventory()
	if hiding == false:
		closeIcons()
	hiding = not hiding
	
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
	
func closeIcons():
	for item in InvGrid.get_children():
		InvGrid.remove_child(item)
		item.queue_free()
#endregion

#region item details
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
			
			itemSelected = true
			selectedItemIndex = index
			selectedAssembledItem = item.assembledItem
			itemDesc.itemSelected = true
			itemDesc.selectedItem = item.assembledItem[0]

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

func _on_use_item() -> void:
	var itemVal
	var satiation
	var hydration
	var health
	if (selectedAssembledItem):
		if (selectedAssembledItem != []):
			if (selectedAssembledItem[0][1] == "Currency"):
				itemVal = selectedAssembledItem[3]
				ledger.money += itemVal
				ledger.addEntry(itemVal, clock.theTime, selectedAssembledItem[0][0], "Redeemed", coinIcon)
				removeItem(selectedItemIndex)
				itemDesc.itemSelected = false
				itemSelected = false
				refreshInventory()
			elif (selectedAssembledItem[0][1] == "Consumable"):
				if !(selectedAssembledItem[0][3] is String):
					satiation = selectedAssembledItem[5]
					if (vitals.satiation + satiation > 100):
						vitals.satiation = 100
					else:
						vitals.satiation += satiation
				if !(selectedAssembledItem[0][4] is String):
					hydration = selectedAssembledItem[4]
					if (vitals.hydration + hydration > 100):
						vitals.hydration = 100
					else:
						vitals.hydration += hydration
				removeItem(selectedItemIndex)
				itemDesc.itemSelected = false
				itemSelected = false
				refreshInventory()
			elif (selectedAssembledItem[0][1] == "Medication"):
				health = snapped((selectedAssembledItem[1] * selectedAssembledItem[5] * 0.01), 1)
				if (vitals.health + health > 100):
					vitals.health = 100
				else:
					vitals.health += health
				removeItem(selectedItemIndex)
				itemDesc.itemSelected = false
				itemSelected = false
				refreshInventory() 
#endregion
