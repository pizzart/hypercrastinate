class_name Buttons
extends Item

var btn_main = preload("res://scenes/Buttons.tscn")

func _ready():
	score = 150

func start_minigame():
	var buttons = btn_main.instance()
	buttons.position += Vector2(-100, -40)
	buttons.connect("win", self, "end_minigame")
	add_child(buttons)
	.start_minigame()
