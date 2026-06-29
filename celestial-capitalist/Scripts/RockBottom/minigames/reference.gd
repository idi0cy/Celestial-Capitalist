extends Sprite2D

var pixelArray = []
var pixelCount:float = 0.0

func reset():
	pixelArray.clear()
	pixelCount = 0.0

#writes all pixels that need to be traced to an array
func writePixelsToArray():
	var image = self.texture.get_image()
	if image.is_compressed():
		image.decompress()
	for x in image.get_width():
		for y in image.get_height():
			var pixel_color: Color = image.get_pixel(x, y)
			if (pixel_color == Color(0.0, 0.0, 0.0, 1.0)):
				pixelArray.append(Vector2(x,y))
	countPixels()

func countPixels():
	for i in pixelArray:
		pixelCount += 1
