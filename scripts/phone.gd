extends Item

const MAXSIZE = 1
var size = 0
var grow_mult = 0.1
var click_reduce = 0.15
var click_enabled: bool = true
var enough: bool

func _ready():
	size = 0.5
	score = 100

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

func end_minigame():
	enough = true
	.end_minigame()

func _on_Phone_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("start_minigame"):
		if click_enabled and not dying:
			Global.play_sound("res://audio/sfx/click.wav")
			if size > click_reduce:
				size -= click_reduce
			collected_score += 0
