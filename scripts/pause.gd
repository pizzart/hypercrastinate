extends CanvasLayer

var disabled: bool

func _input(event):
	if event.is_action_pressed("pause"):
		if not disabled:
			get_tree().paused = !get_tree().paused
			$Control.visible = get_tree().paused
			$Control/Sure.visible = false

func _on_back():
	if $Control/Sure.visible:
		get_tree().paused = false
		$Control.visible = false
		$Control/Sure.visible = false
		get_tree().change_scene("res://scenes/Menu.tscn")
	else:
		$Control/Sure.visible = true
