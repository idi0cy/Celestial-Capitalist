extends Node2D

@onready var sprite = get_node("targetSprite")

var difficulty = 0
var active = false
var reachedDestination = false
#between 379 and 775 and its offset when determining distance
var destination = 379
var random
var random2
var random3
var marker = false

func _process(_delta):
	if active == true:
		position = position.lerp(Vector2(destination, 457), 0.02 / difficulty)
		if abs(position.x - destination) < 5:
			reachedDestination = false
		if get_parent().succeeding == true:
			if sprite.modulate.a < 1:
				sprite.modulate.a += 0.05
				sprite.scale = sprite.scale.lerp(Vector2(0.9, 0.9), 0.1)
		else:
			if sprite.modulate.a > 0.5:
				sprite.modulate.a -= 0.05
				sprite.scale = sprite.scale.lerp(Vector2(1.3, 1.3), 0.1)

func initiate(theDifficulty):
	active = true
	difficulty = theDifficulty
	theEndIsNeverTheEndIsNever()
	jitter()

func jitter():
	if active == true:
		sprite.position.x += randi_range(-2,2)
		sprite.position.y += randi_range(-2,2)
		await get_tree().create_timer(randf_range(0.01, 0.03)).timeout
		#sprite.position = position
		sprite.position = Vector2(0,0)
		jitter()

func theEndIsNeverTheEndIsNever():
	if active == true:
		if reachedDestination == false:
			random2 = randi_range(0, 1)
			var distance = 0
			if 396 - position.x > position.x:
				distance = floor(396 - position.x)
			else:
				distance = floor(position.x)
			if random2 == 0:
				if destination - distance >= 379:
					destination = destination - distance
				else:
					destination = 379
			else:
				if destination + distance <= 755:
					destination += distance
				else:
					destination = 775
			destination = randi_range(379, 775)
		random = randi_range(2,3) * randf()
		await get_tree().create_timer(random).timeout
		theEndIsNeverTheEndIsNever()
