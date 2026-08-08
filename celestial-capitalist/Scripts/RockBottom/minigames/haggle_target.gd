class_name HaggleTarget
extends TextureButton
## Controls the targets that appear in the [Haggle] minigame.

#region nodes
@onready var haggle = get_node("../../../Haggle")
@onready var sellWindow = get_node("../../../../../../sellWind")
#endregion

#region variables
## The base amount of progress clicking a button should provide, pre-modified from the stranger's properties.
const baseProgress = 10

## The type that the target is - either "good" or "bad". This decides the boon or penalty on clicking on it.
var type : String
## The time that the target will last, augmented by the risk factor.
var time
## The modified amount of progress, by the stranger's properties.
var modProgress
#endregion

## Triggered when spawned in with [param localType] "good" or "bad" and [param risk], which modifies the time the target stays..
func initiate(localType, risk):
	## The id/name of the stranger.
	var targetID = haggle.targetID
	modProgress = baseProgress * sellWindow.allStrangers[targetID][4]
	type = localType
	time = (1 / risk)
	
	if type == "good":
		z_index = 8
	else:
		z_index = 5
	
	#Connect self to [method gotPressed] for each instance.
	self.pressed.connect(gotPressed)
	await get_tree().create_timer(time).timeout
	if localType == "good":
		haggle.progress -= 10 * risk / 2
	get_parent().remove_child(self)
	self.queue_free()

## Called when the target is pressed. Multiplies progress received and multiplies the flat 10 progress removed by [member time] and removes the target.
func gotPressed():
	## Temporary variable to store the time to stay, which is influenced by risk. 
	var temp = 1/time
	if type == "good":
		haggle.progress += modProgress * temp
	else:
		haggle.progress -= 10 * temp
	get_parent().remove_child(self)
	self.queue_free()
