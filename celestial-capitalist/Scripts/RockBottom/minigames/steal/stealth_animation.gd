extends Node2D

@onready var hand = get_node("handcomposite/hand")
@onready var coin = get_node("handcomposite/coin")
@onready var handComposite = get_node("handcomposite")
@onready var stealthMain = get_parent()

var active = false

func _process(_delta):
	if active == true:
		update()

func update():
	if stealthMain.progress >= 50:
		coin.show()
	else:
		coin.hide()
	handComposite.position.x = abs(stealthMain.progress - 50) * -12 + 300
	#print(abs(stealthMain.progress - 50))
