extends Node2D

signal tut_item_done
enum Types {
	PHONE,
	BULB,
	MAZE,
	BUTTONS,
}
var phone = preload("res://scenes/Phone.tscn")
var tut = preload("res://scenes/TutorialText.tscn")

func _ready():
	get_parent().tutorial = true
	AudioServer.set_bus_effect_enabled(0, 0, true)

	yield(get_tree().create_timer(0.5), "timeout")

	add_tut_item("gotyz", Types.BULB, Vector2(0, -600), "put falling items in the basket")
	yield(self, "tut_item_done")
	yield(get_tree().create_timer(1.0), "timeout")

	add_tut_item("book", Types.PHONE, Vector2(0, -200), "repeatedly click on the icon on the phone")
	yield(self, "tut_item_done")
	yield(get_tree().create_timer(1.0), "timeout")

	add_tut_item("shower", Types.MAZE, Vector2(0, -200), "move the item through the maze using WASD")
	yield(self, "tut_item_done")
	yield(get_tree().create_timer(1.0), "timeout")

	add_tut_item("can", Types.BUTTONS, Vector2(0, -200), "type the missing letters in the code window")
	yield(self, "tut_item_done")
	yield(get_tree().create_timer(1.0), "timeout")

	add_tut_item("shirt", Types.PHONE, Vector2(0, -200), "every item disappears after some time", false)
	yield(self, "tut_item_done")

	get_parent().get_node("Interface/Interface/Arrow").show()
	add_tut_item("book", Types.BULB, Vector2(0, -600), "don't lose them", false)
	yield(self, "tut_item_done")

	add_tut_item("book", Types.PHONE, Vector2(0, -200), "because the bar fills up if you do")
	yield(self, "tut_item_done")

	get_parent().get_node("Interface/Interface/Arrow").hide()
	add_tut_item("shower", Types.MAZE, Vector2(0, -200), "and once it's full, you can't delay work any longer")
	yield(self, "tut_item_done")

	get_parent().tutorial = false
	AudioServer.set_bus_effect_enabled(0, 0, false)
	Global.save_conf("game", "tut_done", true)

func add_tut_item(icon, type, pos, tut_text, interact_enabled = true):
	var item = add_item(icon, type, pos)
	item.tutorial = true
	if type == Types.BULB:
		item.grab_enabled = interact_enabled
	if type == Types.PHONE:
		item.click_enabled = interact_enabled
	var item_text = tut.instance()
	item_text.text = tut_text
	item.add_child(item_text)
	var wait_signal = "done"
	if not interact_enabled:
		wait_signal = "lost"
	yield(item, wait_signal)
	emit_signal("tut_item_done")

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
	get_parent().add_child(new_item)
	return new_item
