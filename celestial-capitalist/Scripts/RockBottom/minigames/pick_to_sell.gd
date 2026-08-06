class_name PickToSell
extends InventoryHelper
## Controls the pseudo-inventory used to pick items to sell.

#region nodes
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
#endregion

#region variables
## Controls whether the window is open or not.
var hiding = true

#TODO replace when implimenting save game function (WHYYYYY DO I HAVE TO FIGURE THAT OUT?????)
## Inventory contents. Takes assembled items only. Starter items can be added by passing a full assembled item or calling
## [method InventoryHelper.assembleItem].
var currentInv
#endregion

#TODO CHANGE THIS THINGY TO BE NOT THE INV BUTTON
## Call to open the window. Generates the [TextureButton]s for every item and resets the [ItemDesc]
func openPickToSell():
	itemDesc.itemSelected = false
	
	## Increments per every [TextureButton] in [member currentInv] during an inventory refresh. [br]
	## [br]
	## If stored externally during the loop, can be used as the index of a [TextureButton] in the [InvGrid]. [br]
	## [br]
	## For every [TextureButton] in inventory, is used to connect it's [signal Button.pressed] to [method Inventory.generateInfo]
	## with the current count. This makes it so that if the [TextureButton] is pressed, it generates the [InvItemDesc] info and
	## allows [method generateInfo] to accurately store the currently selected [TextureButton].
	var count = 0
	for obj in currentInv:
		## Used to construct a new [TextureButton] for each item.
		var invItem = TextureButton.new()
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
	
## Overrides [method InventoryHelper.generateInfo]. Updates the [InvItemDesc] to
## show and updates the selected index and assembled item of the confirm button.
func generateInfo(desc, item, index := 0):
	super.generateInfo(desc, item)
	itemDesc.itemSelected = true
	confirmButton.selectedIndex = index
	confirmButton.selected = item
	confirmButton.hiding = false

#region screen opening/closing
func closeIcons():
	for item in invGrid.get_children():
		invGrid.remove_child(item)
		item.queue_free()

func _process(_delta):
	currentInv = realInventory.currentInv
	if hiding == true:
		self.hide()
	else:
		self.show()
#endregion
