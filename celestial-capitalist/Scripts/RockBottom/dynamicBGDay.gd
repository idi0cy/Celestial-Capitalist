extends Sprite2D
var _image : Image
var _texture : ImageTexture

@onready var clock = get_node("../../digitalClock")
@onready var mat : ShaderMaterial = material as ShaderMaterial

func _ready() -> void:
	_image = Image.create(50, 70, false, Image.FORMAT_RGBA8)
	_image.fill(Color(0, 0, 0, 0))


func _process(_delta):
	# for every 1 hour, paint 7 columns i think
	var time = clock.theTime
	if mat:
		if (time > 420 && time < 1140):
			self.z_index = -6
			@warning_ignore("integer_division")
			var hours : int = (floori(float(time) / 60))
			var hourUtil : int = hours - 7
			if (hourUtil < 11):
				if (hourUtil == 0):
					_image.fill(Color(0, 0, 0, 0))
				else:
					for h in hourUtil:
						for i in 7:
							var row = 69 - ((h*7)+i)
							for n in 49:
								_image.set_pixel(n, row, Color.WHITE)
				_texture = ImageTexture.create_from_image(_image)
				mat.set_shader_parameter("mask_texture", _texture)
		if (time > 1140 || time < 420):
			self.z_index = -7
#func _input(event):
#	if event.is_action_pressed("debug"):
#		var time = clock.theTime
#		print("Day: ", self.z_index)
#		print("Time: ", time)
