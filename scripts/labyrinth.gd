class_name Labyrinth
extends Item

var maze
var size = 100
var avoid = Vector2()
var grabbing: bool

func _ready():
	connect("area_shape_entered", self, "_on_area_shape_entered")
	connect("area_shape_exited", self, "_on_area_shape_exited")
	score = 150

func start_minigame():
	maze = MazeMain.new()
	maze.size = size
	get_parent().add_child(maze)
	maze.position = position
	scale = Vector2(0.5, 0.5)
	.start_minigame()

func _on_input(_viewport, event, shape_index):
	if minigaming:
		if Input.is_action_pressed("start_minigame"):
			position = get_global_mouse_position()
			if avoid != Vector2():
				if abs(position.x - avoid.x) > abs(position.y - avoid.y):
					if position.x > avoid.x:
						position.x = clamp(position.x, avoid.x + size - 10, INF)
					elif position.x < avoid.x:
						position.x = clamp(position.x, -INF, avoid.x - size + 10)

				else:
					if position.y > avoid.y:
						position.y = clamp(position.y, avoid.y + size - 10, INF)
					elif position.y < avoid.y:
						position.y = clamp(position.y, -INF, avoid.y - size + 10)

			position.x = clamp(position.x, maze.position.x, maze.position.x + size * 4)
			position.y = clamp(position.y, maze.position.y, maze.position.y + size * 4)
	._on_input(_viewport, event, shape_index)

func _on_area_shape_entered(_rid, area, shape_idx, _local):
	if area is MazeMain:
		var shape = area.shape_owner_get_owner(shape_idx)
		avoid = shape.global_position
		if shape.name == "End":
			if is_instance_valid(maze):
				maze.queue_free()
			emit_signal("done")

func _on_area_shape_exited(_rid, area, shape_idx, _local):
	if area is MazeMain:
		var shape = area.shape_owner_get_owner(shape_idx)
		avoid = Vector2()
