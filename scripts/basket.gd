extends Node2D

func _on_area_entered(area: Area2D):
	if "Throw" in area.name:
		area.emit_signal("done")
