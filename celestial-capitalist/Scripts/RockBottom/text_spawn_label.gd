extends Label

var targetText = ""
var breakOut = false

func fillText():
	breakOut = false
	text = ""
	for i in len(targetText):
		if breakOut == false:
			print(i)
			print(len(targetText))
			if i < len(targetText) + 1:
				text += targetText[i]
				await get_tree().create_timer(0.02).timeout
			else:
				break
		else:
			break
