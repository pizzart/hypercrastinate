class_name Buttons
extends Item

var btn_main = preload("res://scenes/Buttons.tscn")
var buttons
onready var cam = get_parent().get_node("Camera")

func _ready():
	score = 150

func start_minigame():
	buttons = btn_main.instance()
	buttons.position += Vector2(-100, -40)
	add_child(buttons)
	.start_minigame()

func end_minigame():
	.end_minigame()
	buttons.get_node("Sprite").animation = "disappear"
	yield(buttons.get_node("Sprite"), "animation_finished")
	buttons.queue_free()
