class_name Labyrinth
extends Item

var maze
var walker
var size = 100
var avoid = Vector2()
var grabbing: bool
var icon = preload("res://graphics/types/maze.png")

func _ready():
	add_to_group("Maze")
	score = 150

func _draw():
	if not minigaming:
		draw_texture(icon, Vector2(-32, 70))

func start_minigame():
	for m in get_tree().get_nodes_in_group("Maze"):
		if m != self:
			print("yuh")
			if m.minigaming:
				m.hide_item()

	Global.play_sound("res://audio/sfx/click.wav")

	maze = MazeMain.new()
	maze.size = size
	add_child(maze)

	walker = MazeWalker.new()
	var walker_spr = spr.duplicate()
	walker_spr.animation = "default"
	walker.add_child(walker_spr)
	walker.add_child(col.duplicate())
	walker.scale = Vector2(0.5, 0.5)
	add_child(walker)

	spr.hide()

	#scale = Vector2(0.5, 0.5)
	.start_minigame()

func hide_item():
	spr.show()
	minigaming = false
	if is_instance_valid(maze):
		maze.queue_free()
	if is_instance_valid(walker):
		walker.queue_free()
	update()
	get_parent().get_node("Normal").volume_db = 0
	get_parent().get_node("Minigame").volume_db = -80

func lose_item():
	if is_instance_valid(maze):
		maze.queue_free()
	if is_instance_valid(walker):
		walker.queue_free()
	.lose_item()
