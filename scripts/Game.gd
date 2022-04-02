extends Node2D

# var item = preload("res://scripts/item.gd")
var phone = preload("res://scenes/Phone.tscn")

func show_achievement():
	pass

func add_item(itemname, pos):
	var new_item = phone.instance()
	new_item.texts = Global.items[itemname]["texts"]
	new_item.item_anim = Global.items[itemname]["icon"]
	new_item.position = pos
	# new_item.anima
	add_child(new_item)

func _ready():
	add_item("gotyz", Vector2(-400, 0))
