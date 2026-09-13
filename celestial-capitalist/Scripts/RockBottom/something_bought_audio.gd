extends AudioStreamPlayer

func _ready():
	PleaseSendHelp.somethingBought.connect(playSound)

func playSound():
	play()
