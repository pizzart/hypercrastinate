class_name Buttons
extends Item

var btn_main = preload("res://scenes/Buttons.tscn")
var buttons

func _ready():
	score = 150

func start_minigame():
	buttons = btn_main.instance()
	buttons.position += Vector2(-100, -40)
	buttons.connect("win", self, "end_minigame")
	add_child(buttons)
	.start_minigame()

func end_minigame():
	buttons.queue_free()
	.end_minigame()
