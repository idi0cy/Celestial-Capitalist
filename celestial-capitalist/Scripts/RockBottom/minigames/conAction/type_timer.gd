extends Timer

var timing = false
var active = false
var count = 0

func startTimer():
	if active == true:
		start()

func initiate():
	count = 0
	active = true
	start()

func stopIt():
	active = false
	return count

func _on_timeout() -> void:
	count += 1
	timing = false
	if active == true:
		startTimer()
