extends ProgressBar

@onready var indicator = get_node("indicator")
@onready var reference = get_node("../reference")
var placeholder = 0
signal endGame
var difficulties = [9, 12, 15, 18]
var difficultyIndex = 0

func _ready():
	pass

func startTimer():
	indicator.text = str(difficulties[difficultyIndex]) + " secs left"
	self.max_value = difficulties[difficultyIndex]
	var timeLeft = difficulties[difficultyIndex]
	for i in self.max_value:
		indicator.text = str(timeLeft) + " secs left"
		self.value += 1
		await get_tree().create_timer(1).timeout
		timeLeft -= 1
	endGame.emit()
