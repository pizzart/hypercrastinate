class_name Item
extends Area2D

signal done
export var collider: Shape2D
export var item_anim: String
export var score: int = 10
export var time_left: float = 10
export var text: String
var collected_score = 0 # Adds to global during lifetime of item
var texts = []
var max_score
var minigaming: bool
var notif = preload("res://scenes/DisappearText.tscn")
var global_notify_inst
var col = CollisionShape2D.new()
var dying = false
var type: String
var RNG = RandomNumberGenerator.new()

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

	if not bg_anim == null:
		bg_anim.frame = 0
		bg_anim.playing = true

		bg_anim.animation = "appear"
		bg_anim.connect("animation_finished", self, "next_anim")
		bg_anim.modulate = Color(0.3, 0.3, 0.3)

func next_anim():
	if bg_anim.animation != "default":
		bg_anim.animation = "default"
	if dying:
		queue_free()

func _physics_process(delta): 
	return
	if (score > max_score):
		pass

func start_minigame():
	minigaming = true

func rand_notif():
	Global.score += collected_score 
	collected_score = 0
	if texts.size() == 0:
		notify(text)
	else:
		notify(texts[RNG.randi_range(0, texts.size()-1)])

func notify(thistext):
	if is_instance_valid(global_notify_inst):
		return
	var notif_inst = notif.instance()
	notif_inst.get_node("DisappearText").text = thistext
	get_parent().add_child(notif_inst)
	notif_inst.position = position + Vector2(-350, 0)
	global_notify_inst = notif_inst

func end_minigame():
	Global.score += score
	Global.emit_signal("score_updated")
	# notify(text)
	get_parent().increase_type(type)
	rand_notif()
	if not bg_anim == null:
		bg_anim.animation = "disappear"
		spr.animation = "disappear"
		dying = true
	else:
		queue_free()

func _on_input(_viewport, event, _shape_index):
	if event.is_action_pressed("start_minigame"):
		if not minigaming:
			start_minigame()
