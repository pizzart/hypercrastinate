class_name Item
extends StaticBody2D

export var collider: Shape2D
export(ImageTexture) var sprite
var time_left: float = 10

func _ready():
	connect("input_event", self, "_on_input")
	input_pickable = true
	var col = CollisionShape2D.new()
	col.shape = collider
	add_child(col)

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		queue_free()

func start_minigame():
	print("wahoo")

func _on_input(_viewport, event, _shape_index):
	if event.is_action_pressed("start_minigame"):
		start_minigame()
