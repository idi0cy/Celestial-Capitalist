extends TextureButton

var type = "good"
var time = 1
var baseProgress = 10
var modProgress
var target
#signal uhhPressedBro(magnitude)

@onready var haggle = get_node("../../../Haggle")
@onready var sellWindow = get_node("../../../../../../sellWind")
@onready var allStrangers = sellWindow.allStrangers

func initiate(incType, magnitude):
	#this is so vestigial but i'm keeping it anyways
	target = haggle.target
	modProgress = baseProgress * allStrangers[target][4]
	type = incType
	time = (1 / magnitude)
	#print(time)
	if type == "good":
		z_index = 8
	else:
		z_index = 5
	self.pressed.connect(gotPressed)
	await get_tree().create_timer(time).timeout
	if incType == "good":
		haggle.progress -= 10 * magnitude / 2
	get_parent().remove_child(self)
	self.queue_free()

func gotPressed():
	var temp = 1/time
	if type == "good":
		haggle.progress += modProgress * temp
	else:
		haggle.progress -= 10 * temp
	get_parent().remove_child(self)
	self.queue_free()
