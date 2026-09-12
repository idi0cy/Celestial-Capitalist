extends TextureProgressBar

@onready var clock = get_node("../../../digitalClock")
@onready var dext = get_node("../dextSkill/moreButton")
@onready var strength = get_node("../StrengthSkill/moreButton")
@onready var charisma = get_node("../charismaSkill/moreButton")
@onready var perc = get_node("../percSkill/moreButton")
@onready var luck = get_node("../luckSkill/moreButton")
@onready var buffLabel = get_node("../buffTime")

var buff = false
var lastDecrement = 720

func _process(_delta: float):
	if clock.trueTime == lastDecrement + 1:
		value -= 1
		lastDecrement = clock.trueTime
	if value == 0 && buff:
		dext.resetBuff()
		strength.resetBuff()
		charisma.resetBuff()
		perc.resetBuff()
		luck.resetBuff()
		buff = false
		buffLabel.text = ""
