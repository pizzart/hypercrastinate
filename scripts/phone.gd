extends Item

const MAXSIZE = 1
var size = 0
var grow_mult = 0.1
var click_reduce = 0.15
var click_enabled: bool = true
var enough: bool
var cookie = preload("res://scenes/CookieParticles.tscn")
onready var bg_anim = get_node("BG")

func _ready():
	size = 0.5
	score = 100

	bg_anim.frame = 0
	bg_anim.playing = true

	bg_anim.animation = "appear"
	bg_anim.connect("animation_finished", self, "next_anim")
	bg_anim.modulate = Color(0.3, 0.3, 0.3)

func _process(delta):
	size = clamp(size + delta * grow_mult, 0, 1.1)
	spr.scale = Vector2(size, size)

	if not tutorial or not click_enabled:
		if size > MAXSIZE:
			lose_item()
	if size < click_reduce:
		if not enough:
			emit_signal("done")

	if size > 0.8:
		modulate = Color.red
	if size < 0.7:
		modulate = Color.white

func next_anim():
	if bg_anim.animation != "default":
		bg_anim.animation = "default"
	.next_anim()

func end_minigame():
	enough = true
	bg_anim.animation = "disappear"
	.end_minigame()

func _on_Phone_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("start_minigame"):
		if click_enabled and not dying:
			Global.play_sound("res://audio/sfx/click.wav")
			var cookie_inst = cookie.instance()
			get_parent().add_child(cookie_inst)
			cookie_inst.position = position
			if size > click_reduce:
				size -= click_reduce
			collected_score += 0
