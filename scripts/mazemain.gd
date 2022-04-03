class_name MazeMain
extends Area2D

var size
var preset = [
	[2,0,0,0,1],
	[1,1,1,0,0],
	[0,0,0,1,0],
	[0,1,0,0,0],
	[3,1,1,0,0],
]
var selected = []
var basket = preload("res://graphics/basket.png")

func _ready():
	create_maze()

func _draw():
	var correlate = []
	for idx in selected:
		var cor = preset[((idx - 1) - ((idx - 1) % preset[0].size()) - 1) / 4][(idx - 1) % preset[0].size()]
		if cor == 0:
			correlate.append(Vector2(((idx - 1) - ((idx - 1) % preset[0].size()) - 1) / 4, (idx - 1) % preset[0].size()))
	for y in range(preset.size()):
		for x in range(preset[y].size()):
			var col = Color.white
			if preset[y][x] == 1:
				col = Color.red
			if preset[y][x] == 2:
				col = Color.teal
			if preset[y][x] == 3:
				col = Color.green
			if Vector2(y, x) in correlate:
				col = Color.blue
			if preset[y][x] == 3:
				draw_texture(basket, Vector2(x * size - size / 2, y * size - size / 2))
			else:
				draw_arc(Vector2(x * size, y * size), size / 2, 0, PI * 2, 15, col, 2, true)

func create_maze():
	for y in range(preset.size()):
		for x in range(preset[y].size()):
			if preset[y][x] == 1 or preset[y][x] == 3:
				var col = CollisionShape2D.new()
				col.shape = RectangleShape2D.new()
				col.shape.extents.x = size / 2
				col.shape.extents.y = size / 2
				col.position = Vector2(x * size, y * size)
				if preset[y][x] == 3:
					col.name = "End"
				add_child(col)
