extends Label

func _on_anim_done(_anim_name: String):
	get_parent().queue_free()
