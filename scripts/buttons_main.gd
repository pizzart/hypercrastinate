extends Node2D

signal win
var pressed: int = 0

func _ready():
	$Sprite.frame = 0
	$Sprite/LineEdit.grab_focus()
	yield($Sprite, "animation_finished")
	$Sprite.animation = "default"

func _on_text_changed(text: String):
	if text.to_lower() == "pro":
		emit_signal("win")
