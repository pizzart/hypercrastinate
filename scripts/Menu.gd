extends Control

func _on_started():
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_exited():
	get_tree().quit()
