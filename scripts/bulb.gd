class_name Bulb
extends Item

var grabbing: bool

func _ready():
	connect("area_entered", self, "_on_area_entered")
	start_minigame()

func _process(delta):
	if not tutorial:
		if minigaming:
			position.y = clamp(position.y + delta * 300, -700, 540)
		if position.y > 530:
			lose_item()
	if tutorial:
		if minigaming:
			position.y = clamp(position.y + delta * 200, -700, 450)

	if grabbing:
		position.x = clamp(get_global_mouse_position().x, -1920/2, 1920/2)
		position.y = clamp(get_global_mouse_position().y, -1080/2, 1080/2)
		get_parent().get_node("Basket/BasketArea/CollisionShape2D").disabled = false

func start_minigame():
	.start_minigame()
	get_parent().get_node("Normal").volume_db = 0
	get_parent().get_node("Minigame").volume_db = -80

func end_minigame():
	get_parent().get_node("Basket").disappear()
	get_parent().get_node("Basket/BasketArea/CollisionShape2D").disabled = true
	grabbing = false
	.end_minigame()

func _on_input(_viewport, event, _shape_index):
	if minigaming:
		if event.is_action_pressed("start_minigame"):
			get_parent().get_node("Basket").appear()
			get_parent().get_node("Normal").volume_db = -80
			get_parent().get_node("Minigame").volume_db = 0
			grabbing = true
		if event.is_action_released("start_minigame"):
			get_parent().get_node("Basket").disappear()
			get_parent().get_node("Normal").volume_db = 0
			get_parent().get_node("Minigame").volume_db = -80
			grabbing = false

func _on_area_entered(area: Area2D):
	if minigaming:
		if area.name == "BasketArea":
			emit_signal("done")
