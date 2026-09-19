extends CCButton

@onready var textBox = $accountWind/textBox

signal openAccWind

func _ready():
	textBox.text = PleaseSendHelp.saveName
	interactable.text = textBox.text

func _process(_delta):
	if hovering == true:
		placeHolder = outerSprite.scale.lerp(hoverScale, growSpeed)
	else:
		placeHolder = outerSprite.scale.lerp(paddingSize, growSpeed)
	outerSprite.scale = placeHolder

func _on_interactable_mouse_entered() -> void:
	hovering = true

func _on_interactable_mouse_exited() -> void:
	hovering = false

func _on_interactable_pressed() -> void:
	openAccWind.emit()
	outerSprite.scale = paddingSize
	super()
	
func _on_text_box_text_submitted(new_text: String) -> void:
	PleaseSendHelp.saveName = new_text
	interactable.text = textBox.text


func _on_text_box_text_changed(new_text: String) -> void:
	PleaseSendHelp.saveName = new_text
	interactable.text = textBox.text
