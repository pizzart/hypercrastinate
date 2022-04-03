class_name Throw
extends Item

const ITEM_VELOCITY = 1
const MAX_POINTS = 50
var flying: bool
var velocity: Vector2
var basket = preload("res://scenes/Basket.tscn")
var basket_inst
var fake
var aiming: bool
var line = Line2D.new()
onready var init_pos = position

func _ready():
	line.default_color = Color.teal
	line.width = 5
	line.antialiased = true
	add_child(line)
	fake = Sprite.new()
	fake.scale *= 1.5
	fake.rotation_degrees = -52
	fake.modulate.a = 0.3
	fake.texture = load("res://graphics/basket.png")
	fake.position.x += 500
	add_child(fake)

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		queue_free()

	if aiming:	
		col.scale = Vector2(4, 4)
		update_trajectory(0.1)
		if Input.is_action_just_released("start_minigame"):
			col.scale = Vector2(0.7, 0.7)
			flying = true
			aiming = false
			velocity = to_local(get_global_mouse_position()).clamped(100) * ITEM_VELOCITY
			line.clear_points()

	if flying:
		velocity.y += 10 * delta * 10
		if get_overlapping_bodies().size() > 0:
			velocity /= 2
		position += velocity * delta * 10
		if position.y > init_pos.y + 40:
			if is_instance_valid(basket_inst):
				basket_inst.queue_free()
			queue_free()

func start_minigame():
	get_parent().get_node("Normal").volume_db = -80
	get_parent().get_node("Minigame").volume_db = 0

	fake.queue_free()
	basket_inst = basket.instance()
	get_parent().add_child(basket_inst)
	basket_inst.position = position + Vector2(500, 0)

	.start_minigame()

func end_minigame():
	get_parent().get_node("Normal").volume_db = 0
	get_parent().get_node("Minigame").volume_db = -80
	basket_inst.queue_free()
	.end_minigame()

func update_trajectory(delta):
	line.clear_points()
	var pos = Vector2()
	var vel = to_local(get_global_mouse_position()).clamped(100) * ITEM_VELOCITY
	for i in MAX_POINTS:
		line.add_point(pos)
		vel.y += 10 * delta
		pos += vel * delta
		if pos.y > global_position.y + 25:
			break

func _on_input(_v, event, _i):
	if minigaming and not flying:
		aiming = true
	._on_input(_v, event, _i)
