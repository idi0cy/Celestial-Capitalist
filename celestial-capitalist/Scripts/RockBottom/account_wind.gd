extends Sprite2D
var accWindOpen = false

func _on_account_open_acc_wind() -> void:
	openAccWind()
	
func _process(_delta):
	if accWindOpen == false:
		self.hide()
	else:
		self.show()
		
func openAccWind():
	accWindOpen = not accWindOpen
