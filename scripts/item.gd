class_name Item
extends StaticBody2D

signal done
export var collider: Shape2D
export(StreamTexture) var sprite
export var score: int = 10
export var time_left: float = 10
export var text: String
var minigaming: bool
var notif = preload("res://scenes/DisappearText.tscn")
var col = CollisionShape2D.new()

func _ready():
	connect("input_event", self, "_on_input")
	connect("done", self, "end_minigame")
	input_pickable = true
	col.shape = collider
	add_child(col)
	var spr = Sprite.new()
	spr.texture = sprite
	add_child(spr)

func _process(delta):
	if not minigaming:
		time_left -= delta
		if time_left <= 0:
			queue_free()

func start_minigame():
	minigaming = true

func end_minigame():
	Global.score += score
	var notif_inst = notif.instance()
	notif_inst.get_node("DisappearText").text = text
	get_parent().add_child(notif_inst)
	notif_inst.position = position + Vector2(-350, 0)
	queue_free()

func _on_input(_viewport, event, _shape_index):
	if event.is_action_pressed("start_minigame"):
		if not minigaming:
			start_minigame()
