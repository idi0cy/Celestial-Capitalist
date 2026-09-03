extends Node2D

@onready var eventDesc = get_node("eventDescription")

func initiate(text):
	eventDesc.text = text

func _on_back_button_pressed() -> void:
	get_parent().remove_child(self)
	self.queue_free()

func _on_interactable_pressed() -> void:
	get_parent().remove_child(self)
	self.queue_free()
