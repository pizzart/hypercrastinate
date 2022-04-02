extends Label

func _on_anim_done(_anim_name: String):
	queue_free()
