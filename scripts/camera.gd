extends Camera2D

func _process(_delta):
	offset = position.direction_to(get_global_mouse_position()) * position.distance_to(get_global_mouse_position()) / 60
