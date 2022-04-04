class_name MazeWalker
extends KinematicBody2D

var movement: Vector2

func _ready():
	input_pickable = true

func _process(delta):
	if get_parent().minigaming:
		movement = Input.get_vector("left", "right", "up", "down") * delta * 100000
		movement = move_and_slide(movement)
		position.x = clamp(position.x, 0, get_parent().size * 4)
		position.y = clamp(position.y, 0, get_parent().size * 4)
