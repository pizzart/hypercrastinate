class_name Item
extends StaticBody2D

signal done
export var collider: Shape2D
export(SpriteFrames) var item_anim
export var score: int = 10
export var time_left: float = 10
export var text: String
var texts = []
var minigaming: bool
var notif = preload("res://scenes/DisappearText.tscn")
var col = CollisionShape2D.new()

onready var spr = AnimatedSprite.new()
onready var bg_anim = get_node("BG")

func _ready():
	connect("input_event", self, "_on_input")
	connect("done", self, "end_minigame")
	input_pickable = true
	col.shape = collider
	add_child(col)
	spr.playing = true
	spr.frames = load(item_anim)
	add_child(spr)
	bg_anim.frame = 0
	bg_anim.playing = true

func _process(delta):
	pass
	# if not minigaming:
	# 	time_left -= delta
	# 	if time_left <= 0:
	# 		queue_free()

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
