extends Node2D

var item = preload("res://scripts/item.gd")
var phone = preload("res://scenes/Phone.tscn")

func show_achievement():
	pass

func add_item(itemname):
	var new_item = phone.instance()
	new_item.texts = Global.items[itemname]["texts"]
	new_item.sprite = Global.items[itemname]["icon"]
	add_child(new_item)

func _ready():
	add_item("gotyz")
	pass # Replace with function body.
