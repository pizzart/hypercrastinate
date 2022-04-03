class_name Labyrinth
extends Item

var size = 100
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
			if minigaming:
				col.a = 1
			else:
				col.a = 0.5
			draw_arc(Vector2(x * size, y * size), size / 2, 0, PI * 2, 15, col, 2, true)

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
	get_parent().get_node("Normal").volume_db = -80
	get_parent().get_node("Minigame").volume_db = 0
	.start_minigame()
	update()

func end_minigame():
	get_parent().get_node("Normal").volume_db = 0
	get_parent().get_node("Minigame").volume_db = -80
	.end_minigame()

func _on_input(_viewport, event, shape_index):
	if minigaming:
		if event is InputEventMouseMotion and Input.is_action_pressed("start_minigame"):
			if not shape_index in selected:
				if selected.size() == 0:
					if shape_index == 1:
						selected.append(shape_index)
				else:
					selected.append(shape_index)

		if event.is_action_released("start_minigame"):
			selected.clear()

		if selected.size() > 0:
			var correlate = []
			for idx in selected:
				correlate.append(preset[((idx - 1) - ((idx - 1) % preset[0].size()) - 1) / 4][(idx - 1) % preset[0].size()])
			if correlate.count(1) == 0:
				if correlate[0] == 2 and correlate[-1] == 3 and correlate.count(0) >= amount:
					emit_signal("done")
			else:
				selected.clear()

		update()
	._on_input(_viewport, event, shape_index)
