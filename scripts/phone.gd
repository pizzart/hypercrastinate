extends Item

const MAXSIZE = 1
var size = 0
var grow_mult = 0.1
var click_reduce = 0.1

func _ready():
	pass

func _process(delta):
	size += delta * grow_mult
	spr.scale = Vector2(size, size)

	if size > MAXSIZE:
		end_minigame()

	if (size < click_reduce):
		notify(texts[0])

func _on_Phone_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("start_minigame"):
		if size > click_reduce:
			size -= click_reduce
