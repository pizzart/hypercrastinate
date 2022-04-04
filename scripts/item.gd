class_name Item
extends Area2D

signal done
signal lost
var collider: Shape2D
var item_anim: String
var score: int = 50
var time_left: float = 10
var blink_counter: float
var text: String
var collected_score = 0 # Adds to global during lifetime of item
var texts = []
var max_score
var minigaming: bool
var global_notify_inst
var col = CollisionShape2D.new()
var dying = false
var type: String
var tutorial: bool
var notif = preload("res://scenes/DisappearText.tscn")
var shatter = preload("res://scenes/ShatterParticles.tscn")
var RNG = RandomNumberGenerator.new()

onready var spr = AnimatedSprite.new()
onready var bg_anim = get_node("BG")

func _ready():
	RNG.randomize()

	connect("input_event", self, "_on_input")
	connect("done", self, "end_minigame")
	input_pickable = true
	col.shape = collider
	add_child(col)
	spr.playing = true
	spr.frames = load(item_anim)
	spr.connect("animation_finished", self, "next_anim")
	add_child(spr)

	if not bg_anim == null:
		bg_anim.frame = 0
		bg_anim.playing = true

		bg_anim.animation = "appear"
		bg_anim.connect("animation_finished", self, "next_anim")
		bg_anim.modulate = Color(0.3, 0.3, 0.3)


func _process(delta):
	if not minigaming:
		blink_counter += delta
		if blink_counter > 0.5:
			modulate = Color(2, 2, 2)
		if blink_counter > 1:
			modulate = Color(1, 1, 1)
			blink_counter = 0
		if time_left < 5:
			modulate.r = 4

	if not tutorial:
		time_left -= delta
		if time_left <= 0:
			lose_item()

func next_anim():
	if not bg_anim == null:
		if bg_anim.animation != "default":
			bg_anim.animation = "default"
	if spr.animation != "default":
		spr.animation = "default"
	if dying:
		queue_free()

func start_minigame():
	minigaming = true
	modulate = Color(1, 1, 1)
	update()
	get_parent().get_node("Normal").volume_db = -80
	get_parent().get_node("Minigame").volume_db = 0

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
	notif_inst.position = position + Vector2(100, 0)
	global_notify_inst = notif_inst

func end_minigame():
	get_parent().get_node("Normal").volume_db = 0
	get_parent().get_node("Minigame").volume_db = -80
	get_parent().lose_score(-score / 2)
	Global.score += score
	Global.emit_signal("score_updated")
	Global.play_sound("res://audio/sfx/mgdone.wav")
	# notify(text)
	get_parent().increase_type(type)
	rand_notif()
	spr.animation = "disappear"
	dying = true
	if not bg_anim == null:
		bg_anim.animation = "disappear"
	minigaming = false

func lose_item():
	emit_signal("lost")
	Global.play_sound("res://audio/sfx/loseitem.wav")
	get_parent().get_node("Normal").volume_db = 0
	get_parent().get_node("Minigame").volume_db = -80
	var particles = shatter.instance()
	get_parent().add_child(particles)
	particles.position = position
	get_parent().lose_score(score)
	queue_free()

func _on_input(_viewport, event, _shape_index):
	if event.is_action_pressed("start_minigame"):
		if not minigaming and not dying:
			start_minigame()
