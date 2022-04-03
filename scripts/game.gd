extends Node2D


enum Types {
	PHONE,
	BULB,
	MAZE,
	BUTTONS,
}
var time_elapsed: float
var time_next: float = 5
var counter = {}
# var item = preload("res://scripts/item.gd")
var phone = preload("res://scenes/Phone.tscn")
var RNG = RandomNumberGenerator.new()
onready var bottom_notification = preload("res://scenes/Notification.tscn")

func _ready():
	RNG.randomize()
	add_item("gotyz", Types.PHONE, Vector2(-400, 0))
	add_item("book", Types.BULB, Vector2(400, 0))
	add_item("shower", Types.BUTTONS, Vector2(0, -200))

func _process(delta):
	time_elapsed += delta
	time_next -= delta
	if time_next <= 0:
		time_next = RNG.randf_range(7 / sqrt(time_elapsed), 10 / sqrt(time_elapsed))
		var gotten = get_type()
		var type = gotten[0]
		var pos = gotten[1]
		add_item(Global.items.keys()[RNG.randi() % Global.items.keys().size()], type, pos)

func get_type():
	var type = RNG.randi() % Types.size()
	var pos
	match type:
		Types.PHONE:
			pos = Vector2(RNG.randf_range(-900, 900), RNG.randf_range(-500, 500))
		Types.BULB:
			pos = Vector2(RNG.randf_range(-900, 900), RNG.randf_range(-1000, -700))
		Types.MAZE:
			pos = Vector2(RNG.randf_range(-900, 400), RNG.randf_range(-500, 0))
		Types.BUTTONS:
			pos = Vector2(RNG.randf_range(-800, 800), RNG.randf_range(-400, 400))
	return [type, pos]

func get_chance(value, chance):
	print()

func show_achievement(inter_name: String):
	var new_achiv = bottom_notification.instance()
	get_node("Interface/Interface/Achievements").add_child(new_achiv)
	new_achiv.init_notif(Global.achievements[inter_name]["title"], Global.achievements[inter_name]["text"])

func add_item(itemname, type, pos):
	var new_item
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(80, 80)
	match type:
		Types.PHONE:
			new_item = phone.instance()
		Types.BULB:
			new_item = Bulb.new()
			new_item.collider = shape
		Types.MAZE:
			new_item = Labyrinth.new()
			new_item.collider = shape
		Types.BUTTONS:
			new_item = Buttons.new()
			new_item.collider = shape
		_:
			new_item = Bulb.new()
			new_item.collider = shape
	new_item.texts = Global.items[itemname]["texts"]
	new_item.item_anim = Global.items[itemname]["icon"]
	new_item.position = pos
	new_item.type = itemname
	# new_item.anima
	add_child(new_item)

func increase_type(type):
	if Global.items[type].has("win_score"):
		if type in counter:
			counter[type] += 1
		else:
			counter[type] = 1

		if counter[type] == Global.items[type]["win_score"]:
			show_achievement(Global.items[type]["win_achievement"])
