class_name Timing
extends Item

var timing_spr
var perfect_size: float = 1
var time_range: float = 0.2
var size: float
var icon = preload("res://graphics/types/timing.png")

func _ready():
	perfect_size = Global.RNG.randf_range(0.8, 1.2)

func _draw():
	if not minigaming:
		draw_texture(icon, Vector2(-32, 70))

func _process(delta):
	if minigaming:
		if not tutorial:
			size = clamp(size + delta, 0, perfect_size + time_range + 0.1)
		else:
			size = clamp(size + delta, 0, perfect_size)
		timing_spr.scale = Vector2(size, size)
		if size > perfect_size - time_range and size < perfect_size + time_range:
			spr.modulate = Color(4, 4, 1, 1)
			if Input.is_action_just_pressed("time"):
				emit_signal("done")
		else:
			spr.modulate = Color(1, 1, 1, 0.5)
			if Input.is_action_just_pressed("time"):
				lose_item()
		if size > perfect_size + time_range:
			if not tutorial:
				lose_item()

func start_minigame():
	Global.play_sound("res://audio/sfx/click.wav")
	timing_spr = spr.duplicate()
	timing_spr.scale = Vector2()
	add_child(timing_spr)
	spr.scale = Vector2(perfect_size, perfect_size)
	.start_minigame()

func end_minigame():
	timing_spr.animation = "disappear"
	.end_minigame()
