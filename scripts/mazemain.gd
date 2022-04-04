class_name MazeMain
extends StaticBody2D

var size
var presets = [
	[[2,0,0,0,1],
	[0,1,1,0,1],
	[0,0,0,1,0],
	[0,1,1,0,0],
	[0,0,0,0,3],],

	[[2,0,0,0,1],
	[0,1,1,0,0],
	[0,1,1,1,0],
	[0,0,1,3,0],
	[1,1,1,1,1],],
]
var preset
var selected = []
var basket = preload("res://graphics/basket.png")

func _ready():
	preset = presets[Global.RNG.randi() % presets.size()]
	create_maze()

func _draw():
	for y in range(preset.size()):
		for x in range(preset[y].size()):
			if preset[y][x] == 3:
				draw_texture(basket, Vector2(x * size - size / 2, y * size - size / 2))
			else:
				var col = Color.white
				if preset[y][x] == 1:
					col = Color.red
				if preset[y][x] == 2:
					col = Color.teal
				draw_arc(Vector2(x * size, y * size), size / 2, 0, PI * 2, 20, col, 2, true)

func create_maze():
	for y in range(preset.size()):
		for x in range(preset[y].size()):
			var col = CollisionShape2D.new()
			col.shape = RectangleShape2D.new()
			col.shape.extents.x = size / 2
			col.shape.extents.y = size / 2
			if preset[y][x] == 1:
				col.position = Vector2(x * size, y * size)
				add_child(col)
			elif preset[y][x] == 3:
				var area = Area2D.new()
				area.add_child(col)
				area.position = Vector2(x * size, y * size)
				area.connect("body_entered", self, "_on_body")
				add_child(area)

func _on_body(body):
	if body is KinematicBody2D:
		get_parent().emit_signal("done")
