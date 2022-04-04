class_name Labyrinth
extends Item

var maze
var walker
var size = 100
var avoid = Vector2()
var grabbing: bool

func _ready():
	score = 150

func start_minigame():
	self_modulate.a = 0

	maze = MazeMain.new()
	maze.size = size
	add_child(maze)

	walker = MazeWalker.new()
	walker.add_child(spr.duplicate())
	walker.add_child(col.duplicate())
	walker.scale = Vector2(0.5, 0.5)
	add_child(walker)

	#scale = Vector2(0.5, 0.5)
	.start_minigame()

func lose_item():
	if is_instance_valid(maze):
		maze.queue_free()
	if is_instance_valid(walker):
		walker.queue_free()
	.lose_item()
