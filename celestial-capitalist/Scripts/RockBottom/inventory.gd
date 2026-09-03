class_name Inventory
extends InventoryHelper
## Central player inventory.
##
## Controls the player's inventory. Items can only be used from this inventory.
## Call to refresh the inventory and update it based on the [member currentInv] array.
## If an item is modified in the [member currentInv] array, call this after to sync it.
func refreshInventory():
	## Increments per every [TextureButton] in [member currentInv] during an inventory refresh. [br]
	## [br]
	## If stored externally during the loop, can be used as the index of a [TextureButton] in the [InvGrid]. [br]
	## [br]
	## For every [TextureButton] in inventory, is used to connect it's [signal Button.pressed] to [method Inventory.generateInfo]
	## with the current count. This makes it so that if the [TextureButton] is pressed, it generates the [InvItemDesc] info and
	## allows [method generateInfo] to accurately store the currently selected [TextureButton].
	var count: int
	itemDesc.itemSelected = false
	itemSelected = false
	selectedAssembledItem = []
	count = 0
	for child in invGrid.get_children():
		invGrid.remove_child(child)
		child.queue_free()
	for obj in currentInv:
		## Used to construct a new [TextureButton] for each item.
		var invItem : TextureButton = TextureButton.new()
		invItem.name = "inv" + str(count)
		invItem.texture_normal = obj[0][-1]
		invItem.texture_pressed = obj[0][-2]
		invItem.set_script(invItemScript)
		invItem.assembledItem = obj
		invItem.baseItem = obj[0]
		invItem.pressed.connect(generateInfo.bind(itemDesc, invItem.assembledItem, count))
		invGrid.add_child(invItem)
		count += 1

#region nodes
@onready var invGrid : Node = get_node("scrollContainer/InvGrid")

@onready var itemDesc : Node = get_node("itemDesc")
@onready var itemNameDisplay : Node = get_node("itemDesc/Item")
@onready var qualDisplay : Node = get_node("itemDesc/infoBarOne/Quality")
@onready var valDisplay : Node = get_node("itemDesc/infoBarOne/Value")
@onready var hydrationDisplay : Node = get_node("itemDesc/infoBarOne/Hydration")
@onready var satiationDisplay : Node = get_node("itemDesc/infoBarOne/Satiation")
@onready var itemIcon : Node = get_node("itemDesc/itemIcon")
@onready var flavourText : Node = get_node("itemDesc/flavourText")

@onready var terminal : Node = get_node("../terminal")
@onready var terminalText : Node = get_node("../terminal/termText")

@onready var vitals : Node = get_node("../vitals")
@onready var ledger : Node = get_node("../Ledger")
@onready var clock : Node = get_node("../../digitalClock")
#endregion

#region variables
## Determines whether the inventory is shown or hidden. Pressing inventory button inverts this value.
var hiding : bool = true
## Determines whether a [TextureButton] is currently selected. Currently unused in favour of [member Inventory.selectedAssembledItem]. 
## Do not delete; may be useful later on.
var itemSelected : bool = false
## Stores the currently selected [TextureButton]'s assembled item. Can be used to check if item is selected and operate using that item's properties. 
## Cannot be used to change the selected item.
var selectedAssembledItem:Array
## Stores the index of the currently selected [TextureButton] in the [InvGrid]. [br]
## [br]
## Can be used to get and set the current assembled item, using [code]invGrid.get_child(selectedItemIndex).assembledItem[/code]. [br] 
## [br]
## [param assembledItem] is stored in each [TextureButton].
var selectedItemIndex : int
#endregion
 
## Inventory contents. Takes assembled items only. Starter items can be added by passing a full assembled item or calling
## [method InventoryHelper.assembleItem].
@onready var currentInv = [
	assembleItem(25, waterBottle), assembleItem(50, waterBottle), 
	assembleItem(75, waterBottle), assembleItem(10, pencil),
	assembleItem(25, burger), assembleItem(50, burger),
	assembleItem(50, burger),
]

#region item methods
## Call to add an item to the inventory. Accepts assembled items only. Always use this method so we can know when it happens.
func addItem(assembledItem): currentInv.append(assembledItem)

## Call to remove an item from the inventory. Accepts a [TextureButton] index in the [InvGrid].
## Always use this method so we can know when it happens and refresh as needed.
func removeItem(index):
	currentInv.remove_at(index)
	refreshInventory()
	
## Overrides [method InventoryHelper.generateInfo]. Updates the [InvItemDesc] to
## show and updates [member selectedItemIndex] and [member selectedAssembledItem].
func generateInfo(desc, item, index := 0):
	super.generateInfo(desc, item)
	itemSelected = true
	selectedItemIndex = index
	selectedAssembledItem = item
	itemDesc.itemSelected = true
	itemDesc.selectedItem = item[0]

## Code executed when the use item button is pressed. Checks item type for what function to be performed, performs it, and refreshes inventory. [br]
## [br]
## Currency items add money to the ledger, [br]
## Consumables add to satiation and hydration, [br]
## Medication adds to health. [br]
func _on_use_item() -> void:
	if (selectedAssembledItem):
		if selectedAssembledItem != []:
			
			if selectedAssembledItem[0][1] == "Currency":
				
				## Final value retrieved from assembled item
				var itemVal = selectedAssembledItem[3]
				ledger.money += itemVal
				ledger.addEntry(itemVal, clock.theTime, selectedAssembledItem[0][0],
				"Redeemed", coinIcon)
				removeItem(selectedItemIndex)
				
			elif selectedAssembledItem[0][1] == "Consumable":
				
				if !(selectedAssembledItem[0][3] is String) || !(selectedAssembledItem[0][3] == 0):
					
					## Final satiation retrieved from assembled item
					var satiation = selectedAssembledItem[5]
					if vitals.satiation + satiation > 100:
						vitals.satiation = 100
					else:
						vitals.satiation += satiation
						
				if !(selectedAssembledItem[0][4] is String) || !(selectedAssembledItem[0][4] == 0):
					
					## Final hydration retrieved from assembled item
					var hydration = selectedAssembledItem[4]
					if vitals.hydration + hydration > 100:
						vitals.hydration = 100
					else:
						vitals.hydration += hydration
				removeItem(selectedItemIndex)
				
			elif selectedAssembledItem[0][1] == "Medication":
				
				## Final health bonus calculated from assembled item quality and satiation
				var health = snapped((selectedAssembledItem[1] * selectedAssembledItem[5] * 0.01), 1)
				if vitals.health + health > 100:
					vitals.health = 100
				else:
					vitals.health += health
				removeItem(selectedItemIndex)
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
	for item in invGrid.get_children():
		invGrid.remove_child(item)
		item.queue_free()
#endregion
