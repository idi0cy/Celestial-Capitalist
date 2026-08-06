extends InventoryHelper

#Item dependent variables list
#Index zero is list, index 1 is quality, index 2 is ...

@onready var invGrid = get_node("scrollContainer/InvGrid")
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

var count
var count2
var invItem
var hiding = true

#TODO replace when implimenting save game function (WHYYYYY DO I HAVE TO FIGURE THAT OUT?????)
var currentInv

func _process(_delta):
	currentInv = realInventory.currentInv
	if hiding == true:
		self.hide()
	else:
		self.show()

#TODO CHANGE THIS THINGY TO BE NOT THE INV BUTTON
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
		invItem.pressed.connect(generateInfo.bind(itemDesc, invItem.assembledItem, count))
		invGrid.add_child(invItem)
		count += 1
	
	#if hiding == false:
		#closeIcons()
	hiding = false

func generateInfo(desc, item, index := 0):
	super.generateInfo(desc, item)
	itemDesc.itemSelected = true
	confirmButton.selectedIndex = index
	confirmButton.selected = item
	confirmButton.hiding = false

func closeIcons():
	for item in invGrid.get_children():
		invGrid.remove_child(item)
		item.queue_free()
