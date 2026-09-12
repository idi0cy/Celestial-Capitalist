extends AudioStreamPlayer

func _ready():
	PleaseSendHelp.buttonGotPressed.connect(playSound)

func playSound():
	play()
