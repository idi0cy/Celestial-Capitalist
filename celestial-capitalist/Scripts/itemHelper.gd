class_name ItemHelper
extends Node2D
## A library containing methods for inventory management
##
## Assigns info to any itemDesc node tree and gets quality icon based on stars.

const quality1 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality1.png")
const quality2 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality2.png")
const quality3 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality3.png")
const quality4 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality4.png")
const quality5 = preload("res://assets/Sprites/RockBottom/inventoryIcons/quality5.png")

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

func generateInfo(itemDesc : Node, item : Array):
	var itemVal
	var itemQual
	var itemHydration
	var itemSatiation
	itemQual = item[1]
	itemVal = item[3]
	itemHydration = item[4]
	itemSatiation = item[5]
	
	itemDesc.get_node("flavourText").text = item[0][5]
	itemDesc.get_node("itemIcon").texture = item[0][-1]
	itemDesc.get_node("Item").text = item[2]
	itemDesc.get_node("infoBarOne/Quality").icon = getStars(itemQual)
	itemDesc.get_node("infoBarOne/Quality").text = str(itemQual) + "/100"
	itemDesc.get_node("infoBarOne/Value").text = str(itemVal)
	itemDesc.get_node("infoBarOne/Hydration").text = str(itemHydration)
	itemDesc.get_node("infoBarOne/Satiation").text = str(itemSatiation)
	
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
