class_name InventoryHelper
extends Resources
## A library containing methods for inventory management
##
## Assembles items, puts info in [ItemDesc]s, and gets a quality star icon based on quality. [br] [br]
## [br]
## A base item is the item's default instance. An assembled item is a modified base item.
## Inventories accept assembled items, not base items. [br]
## [br]
## [b]Base Item Indexes:[/b] [br]
## 0 is item name, [br]
## 1 is type, [br]
## 2 is max value, [br]
## 3 is hydration value, [br]
## 4 is satiation value, [br]
## 5 is flavour text [br]
## 6 (Prefer -2) is the shrunken texture [br]
## 7 (Prefer -1) is the normal texture [br]
## [br]
## [b]Assembled Item Indexes:[/b] [br]
## 0 is the base item, [br]
## 1 is the quality, which the last three are calculated from, [br]
## 2 is the display name - generated, easter egg, etc., [br]
## 3 is the value, [br]
## 4 is hydration, [br]
## 5 is satiation [br]
## [br]
## Values with "null" or 0 do not have that property/value attached to the item. [br]

## Assembles an item from a non percentage quality value, a base item, and an optional display name. [br]
## [br]
## [b]Assembled Item Indexes:[/b] [br]
## 0 is the base item, [br]
## 1 is the quality, which the last three are calculated from, [br]
## 2 is the display name - generated, easter egg, etc., [br]
## 3 is the value, [br]
## 4 is hydration, [br]
## 5 is satiation [br]
## [br]
func assembleItem(quality : int, baseItem : Array, displayName : String = baseItem[0]):
	var itemVal = snapped((quality * baseItem[2] * 0.01), 0.01)
	var hydration = 0
	var satiation = 0
	if baseItem[3] is int:
		hydration = snapped((quality * baseItem[3] * 0.01), 1)
	if baseItem[4] is int:
		satiation = snapped((quality * baseItem[4] * 0.01), 1)
	return [baseItem, quality, displayName, itemVal, hydration, satiation]

## Puts info to an [ItemDesc] node and its children from the node and the assembled item.
## Override to attach custom behaviour on selecting an item.
func generateInfo(itemDesc : Node, item : Array):
	var itemQual = item[1]
	var itemVal = item[3]
	var itemHydration = item[4]
	var itemSatiation = item[5]
	
	itemDesc.get_node("flavourText").text = item[0][5]
	itemDesc.get_node("itemIcon").texture = item[0][-1]
	itemDesc.get_node("Item").text = item[2]
	itemDesc.get_node("infoBarOne/Quality").icon = getStars(itemQual)
	itemDesc.get_node("infoBarOne/Quality").text = str(itemQual) + "/100"
	itemDesc.get_node("infoBarOne/Value").text = str(itemVal)
	itemDesc.get_node("infoBarOne/Hydration").text = str(itemHydration)
	itemDesc.get_node("infoBarOne/Satiation").text = str(itemSatiation)

## Takes a non percentage quality value and returns a star amount icon for use in an [ItemDesc]
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

## Item prefix names for use in name generation.
var prefixes = [
	"Dastardly",
	"Cowardly",
	"Heretical",
	"Demonic",
	"Evil",
	"Attractive",
	"Beautiful",
	"Clean",
	"Fancy",
	"Magnificent",
	"Ambitious",
	"Brave",
	"Jolly",
	"Silly",
	"Zealous",
	"Clumsy",
	"Fierce",
	"Mysterious",
	"Spooky",
	"Colossal",
	"Intense",
	"Puny",
	"Acidic",
	"Corny",
	"Cheesy",
	"Cruel",
	"Despicable",
	"Undying",
	"Hilarious",
	"Happy",
	"Hungry",
	"Livid",
	"Outrageous",
	"Tender",
	"Wicked",
	"Flying",
	"Genocidal",
	"Broke",
	"Gleeful"]
