extends Node2D

@onready var haggleBar = get_node("haggleBar")
@onready var terminalText = get_node("../../Terminal/termText")
@onready var sellWindow = get_node("../../../../sellWind")
@onready var dialogueOptions = get_node("dialogue")
@onready var allStrangers = sellWindow.allStrangers

@onready var goodTarget = load("res://assets/Sprites/RockBottom/buttonIcons/goodTarget.png")
@onready var badTarget = load("res://assets/Sprites/RockBottom/buttonIcons/badTarget.png")

@onready var targetScript = load("res://Scripts/RockBottom/minigames/haggle_target.gd")

@onready var progress = 0

var redBar = StyleBoxFlat.new()
var greenBar = StyleBoxFlat.new()
var random
var tries = 10
var target
var iterations = 16

func _ready():
	redBar.bg_color = Color(1.0, 0.353, 0.0, 1.0)
	greenBar.bg_color = Color(0.387, 1.0, 0.356, 1.0)

func _process(_delta):
	if progress < 0:
		progress = 0
	if progress < 50:
		haggleBar.add_theme_stylebox_override("fill", redBar)
		haggleBar.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
		haggleBar.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 1.0))
	else:
		haggleBar.add_theme_stylebox_override("fill", greenBar)
		haggleBar.add_theme_color_override("font_color", Color())
		haggleBar.add_theme_color_override("font_outline_color", Color(1.0, 1.0, 1.0, 1.0))


func _on_promote_promote() -> void:
	universalMinigame(1.25)

func _on_urgency_urgency() -> void:
	if tries > 0:
		pass # Replace with function body.

func _on_recommend_recommend() -> void:
	universalMinigame(1)

func _on_fearmonger_fear_monger() -> void:
	if tries > 0:
		pass # Replace with function body.

func universalMinigame(risk):
	dialogueOptions.hide()
	for item in $aimTrainZone.get_children():
		$aimTrainZone.remove_child(item)
		item.queue_free()
	for i in iterations:
		var greenTarget = TextureButton.new()
		greenTarget.global_position = Vector2(randi_range(360,792), randi_range(240,305))
		greenTarget.texture_normal = goodTarget
		greenTarget.texture_pressed = goodTarget
		greenTarget.set_script(targetScript)
		$aimTrainZone.add_child(greenTarget)
		greenTarget.initiate("good", risk)
		
		var redTarget = TextureButton.new()
		redTarget.global_position = Vector2(randi_range(360,792), randi_range(240,305))
		redTarget.texture_normal = badTarget
		redTarget.texture_pressed = badTarget
		redTarget.set_script(targetScript)
		$aimTrainZone.add_child(redTarget)
		redTarget.initiate("bad", risk)
		
		if i != iterations:
			await get_tree().create_timer(1).timeout
		else:
			await get_tree().create_timer(2).timeout
