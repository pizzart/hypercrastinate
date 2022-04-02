class_name Bulb
extends Item

var particles = preload("res://scenes/ShatterParticles.tscn")

func _ready():
	start_minigame()

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		end_minigame()

	position.y += delta * 200
	if position.y > 550:
		queue_free()

func _on_input(_viewport, event, _shape_index):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("start_minigame"):
			position.y = clamp(get_global_mouse_position().y, -540, 540)
