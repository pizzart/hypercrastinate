extends Node2D

var time_elapsed: float
var time_next: float = 5
# var item = preload("res://scripts/item.gd")
var phone = preload("res://scenes/Phone.tscn")
var RNG = RandomNumberGenerator.new()

func _ready():
	RNG.randomize()
	add_item("gotyz", Vector2(-400, 0))

func _process(delta):
	time_elapsed += delta
	time_next -= delta
	if time_next <= 0:
		time_next = RNG.randf_range(5 / sqrt(time_elapsed), 10 / sqrt(time_elapsed))
		add_item("gotyz", Vector2(RNG.randf_range(-900, 900), RNG.randf_range(-500, 500)))

func show_achievement():
	pass

func add_item(itemname, pos):
	var new_item = phone.instance()
	new_item.texts = Global.items[itemname]["texts"]
	new_item.item_anim = Global.items[itemname]["icon"]
	new_item.position = pos
	add_child(new_item)
