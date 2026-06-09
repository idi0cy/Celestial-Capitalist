extends Label

var targetText = ""

func fillText():
	text = ""
	for i in len(targetText) + 1:
		text = targetText.substr(0,i)
		await get_tree().create_timer(0.01).timeout
