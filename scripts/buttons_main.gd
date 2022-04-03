extends Node2D

signal win
var pressed: int = 0

func _ready():
	$TextureRect/LineEdit.grab_focus()

func _on_text_changed(text: String):
	if text.to_lower() == "pro":
		emit_signal("win")
