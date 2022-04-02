extends Node2D

# var item = preload("res://scripts/item.gd")
var phone = preload("res://scenes/Phone.tscn")

func show_achievement():
	pass

func add_item(itemname):
	var new_item = phone.instance()
	print(Global.items[itemname])
	new_item.texts = Global.items[itemname]["texts"]
	new_item.item_anim = Global.items[itemname]["icon"]
	new_item.max_score = Global.items[itemname]["win_score"]
	add_child(new_item)
	pass

func _ready():
	add_item("gotyz")
