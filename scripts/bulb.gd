class_name Bulb
extends Item

var particles = preload("res://scenes/ShatterParticles.tscn")

func _process(delta):
	position.y += delta * 200
	if minigaming:
		if Input.is_action_pressed("start_minigame"):
			position.y = clamp(get_global_mouse_position().y, -540, 540)
	if position.y > 550:
		queue_free()

func _on_input(_viewport, event, _shape_index):
	if event.is_action_pressed("start_minigame"):
		minigaming = true
	if event.is_action_released("start_minigame"):
		minigaming = false
