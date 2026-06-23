extends Sprite2D

@onready var reference = get_node("../reference")

var image:Image
var genTexture:ImageTexture
var row:int
var column:int
var mousePos:Vector2
var drawingOn:bool
var score:float = 0.0
var drawnPixels = []

func _ready():
	reset()

func reset():
	self.texture = load("res://assets/Sprites/RockBottom/minigames/canvas.png")
	image = Image.create(61, 29, false, Image.FORMAT_RGBA8)
	image.fill(Color(0.0, 0.0, 0.0, 0.0))

func _process(_delta: float) -> void:
	if (drawingOn == true):
		mousePos = get_local_mouse_position()
		#offsets to put it where the mouse actually is, god knows why these are needed
		row = int(roundf(mousePos.x + 30.5))
		column = int(roundf(mousePos.y + 14.5))
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			# brush is a 1*3 pixel shape, the 3 pixels extending right of the mouse
			for i in 3:
				if !(row >= 61 || row < 0 || column >= 29 || column < 0):
					image.set_pixel(row, column, Color.WHITE)
					if !(drawnPixels.has(Vector2(row, column))):
						checkTrace(Vector2(row, column))
						#add pixel to an array so it doesnt get recounted and falsify larger scores
						drawnPixels.append(Vector2(row, column))
					row += 1
			genTexture = ImageTexture.create_from_image(image)
			self.texture = genTexture

func checkTrace(pixel:Vector2):
	if (reference.pixelArray.has(pixel)):
		score += 1
	else:
		score -= 1

#func _input(event):
#	if event.is_action_pressed("debug"):
#		print(score)

func _on_area_2d_mouse_entered() -> void:
	drawingOn = true

func _on_area_2d_mouse_exited() -> void:
	drawingOn = false
