class_name Bulb
extends Item

var particles = preload("res://scenes/ShatterParticles.tscn")
onready var initial_pos = position.y

func _process(delta):
	if minigaming:
		position.y = get_global_mouse_position().y
		if abs(position.y - initial_pos) > 400:
			emit_signal("done")

func start_minigame():
	.start_minigame()

func end_minigame():
	var inst = particles.instance()
	inst.position = position
	get_parent().add_child(inst)
	.end_minigame()
