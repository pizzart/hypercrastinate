class_name Labyrinth
extends Item

var size = 200
var preset = [
	[2,0,0,0,1],
	[1,1,1,0,0],
	[0,0,0,1,0],
	[0,1,0,0,0],
	[3,1,1,0,0],
]
var amount = 13
var selected = []

func _draw():
	for y in range(preset.size()):
		for x in range(preset[y].size()):
			var col = Color.white
			if preset[y][x] == 1:
				col = Color.black
			if preset[y][x] == 2:
				col = Color.red
			if preset[y][x] == 3:
				col = Color.green
			draw_circle(Vector2(x * size, y * size), size / 2, col)

func _process(delta):
	pass
	#if minigaming:
		#position = get_global_mouse_position()

func start_minigame():
	col.disabled = true
	for y in range(preset.size()):
		for x in range(preset[y].size()):
			var col = CollisionShape2D.new()
			col.shape = collider
			col.shape.extents.x = size / 2
			col.shape.extents.y = size / 2
			col.position = Vector2(x * size, y * size)
			add_child(col)
	.start_minigame()

func _on_input(_viewport, event, shape_index):
	if minigaming:
		if event is InputEventMouseMotion and Input.is_action_pressed("start_minigame"):
			if not shape_index in selected:
				selected.append(shape_index)
				#print(selected)

		if event.is_action_released("start_minigame"):
			selected.clear()

		if selected.size() > 0:
			var correlate = []
			for idx in selected:
				correlate.append(preset[((idx - 1) - ((idx - 1) % preset[0].size()) - 1) / 4][(idx - 1) % preset[0].size()])
			if correlate[0] == 2 and correlate[-1] == 3 and correlate.count(0) >= amount:
				emit_signal("done")
	._on_input(_viewport, event, shape_index)
