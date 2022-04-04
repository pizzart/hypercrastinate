class_name Buttons
extends Item

var btn_main = preload("res://scenes/Buttons.tscn")
var buttons
var icon = preload("res://graphics/types/code.png")
onready var cam = get_parent().get_node("Camera")

func _ready():
	score = 150

func _draw():
	if not minigaming:
		draw_texture(icon, Vector2(-32, 70))

func start_minigame():
	Global.play_sound("res://audio/sfx/click.wav")

	buttons = btn_main.instance()
	buttons.position += Vector2(-100, -40)
	add_child(buttons)
	.start_minigame()

func end_minigame():
	.end_minigame()
	buttons.get_node("Sprite").animation = "disappear"
	yield(buttons.get_node("Sprite"), "animation_finished")
	buttons.queue_free()
