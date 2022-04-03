class_name Bulb
extends Item

var grabbing: bool

func _ready():
	connect("area_entered", self, "_on_area_entered")
	start_minigame()

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		queue_free()

	position.y += delta * 300
	if position.y > 550:
		queue_free()

	if grabbing:
		position.x = clamp(get_global_mouse_position().x, -1920/2, 1920/2)
		position.y = clamp(get_global_mouse_position().y, -1080/2, 1080/2)
		get_parent().get_node("Basket/BasketArea/CollisionShape2D").disabled = false

func start_minigame():
	.start_minigame()

func end_minigame():
	get_parent().get_node("Basket").disappear()
	get_parent().get_node("Basket/BasketArea/CollisionShape2D").disabled = true
	.end_minigame()

func _on_input(_viewport, event, _shape_index):
	if event.is_action_pressed("start_minigame"):
		get_parent().get_node("Basket").appear()
		grabbing = true
	if event.is_action_released("start_minigame"):
		get_parent().get_node("Basket").disappear()
		grabbing = false

func _on_area_entered(area: Area2D):
	if area.name == "BasketArea":
		emit_signal("done")
