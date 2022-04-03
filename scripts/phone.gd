extends Item

const MAXSIZE = 1
var size = 0
var grow_mult = 0.1
var click_reduce = 0.15

func _ready():
	size = 0.5

func _process(delta):
	size += delta * grow_mult
	spr.scale = Vector2(size, size)

	if size > MAXSIZE:
		end_minigame()
	if (size < click_reduce):
		end_minigame()

	if (size > 0.8):
		modulate = Color.red
	if (size < 0.7):
		modulate = Color.white

func _on_Phone_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("start_minigame"):
		if size > click_reduce:
			size -= click_reduce
		collected_score += 0
