extends Node2D

@onready var timer = get_node("countdown")
@onready var ring = get_node("theRing")
@onready var circle = get_node("theCircle")

var countdown = 1
signal oldAge
signal clicked(accuracy) #use this later
var mouseIsOver = false
var notClickedYet = true
var active = false

func _ready():
	initiate(1)

func _process(_delta):
	if active == true:
		if Input.is_action_just_pressed("click") and mouseIsOver:
			notClickedYet = false
			clicked.emit(abs(1 - (ring.scale.x / 0.75)))
			timer.stop()
			inexorable()
		if notClickedYet == true:
			ring.scale = Vector2(calculateScale(), calculateScale())
	#do code to update stuff based off time left on timer

func calculateScale():
	var temp
	temp = (4 * (timer.time_left / (countdown + 1.0)))
	
	return temp

func initiate(lengthOfTimeUnitThingHi_eThaN_D_ontWeLovenamingConVentIons):
	timer.wait_time = lengthOfTimeUnitThingHi_eThaN_D_ontWeLovenamingConVentIons
	countdown = lengthOfTimeUnitThingHi_eThaN_D_ontWeLovenamingConVentIons
	timer.start()
	active = true

func _on_countdown_timeout() -> void:
	if notClickedYet == true:
		oldAge.emit()
		get_parent().remove_child(self)
		queue_free()

func _on_area_2d_mouse_entered() -> void:
	mouseIsOver = true

func _on_area_2d_mouse_exited() -> void:
	mouseIsOver = false

func inexorable():
	ring.modulate = Color(1.5*(1 * abs(ring.scale.x - 0.75)), (1 - 1.5*(1 * abs(ring.scale.x - 0.75))),0,1)
	for i in 25:
		await get_tree().create_timer(0.02).timeout
		circle.scale += Vector2(0.04, 0.04)
		circle.modulate.a -= 0.04
	get_parent().remove_child(self)
	queue_free()
