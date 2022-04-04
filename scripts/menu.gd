extends Control

func _ready():
	Pause.disabled = true

func _on_started():
	Global.play_sound("res://audio/sfx/click.wav")
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_exited():
	Global.play_sound("res://audio/sfx/click.wav")
	get_tree().quit()
