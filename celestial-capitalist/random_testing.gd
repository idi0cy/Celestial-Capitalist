extends Node2D

@onready var myThing = $stealthGame
@onready var otherThing = $strengthGame

func _ready():
	pass
	#myThing.initiate(1, 0.9)
	otherThing.initiate(0.9)

func _on_strength_game_all_done(result: Variant) -> void:
	pass # Replace with function body.
	if result == "success":
		print("passed on this side")
	else:
		print("bruh moment")
