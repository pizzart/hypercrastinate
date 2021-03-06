extends Node2D


enum Types {
	PHONE,
	BULB,
	MAZE,
	BUTTONS,
	TIMING,
}
const MAX_SCORE_LOST = 1000
var type_chances = [0.3, 0.6, 0.8, 0.9, 1]
var time_elapsed: float
var time_next: float = 1
var score_lost: float
var counter = {}
var tutorial: bool
# var item = preload("res://scripts/item.gd")
var normal = preload("res://audio/mus/ingame.ogg")
var normalmg = preload("res://audio/mus/ingamemg.ogg")
var panic = preload("res://audio/mus/panic.ogg")
var panicmg = preload("res://audio/mus/panicmg.ogg")
var phone = preload("res://scenes/Phone.tscn")
var tut = preload("res://scenes/Tutorial.tscn")
var over_screen = preload("res://scenes/GameOver.tscn")
var bottom_notification = preload("res://scenes/Notification.tscn")

func _ready():
	Pause.disabled = false
	if not Global.load_conf("game", "tut_done", false) or Global.try_tutorial:
		add_child(tut.instance())
		Global.try_tutorial = false

func _process(delta):
	score_lost = max(score_lost - delta * 30, 0)
	if not tutorial:
		time_elapsed += delta
		time_next -= delta
		if time_next <= 0:
			time_next = Global.RNG.randf_range(7 / sqrt(time_elapsed), 10 / sqrt(time_elapsed))
			var gotten = get_type()
			var type = gotten[0]
			var pos = gotten[1]
			add_item(Global.items.keys()[Global.RNG.randi() % Global.items.keys().size()], type, pos)

	if Global.score <= 5000:
		$BG/BGLayer/Add1.modulate.a = float(Global.score) / 5000
	elif Global.score <= 10000:
		$BG/BGLayer/Add2.modulate.a = float(Global.score - 5000) / 5000
	elif Global.score <= 15000:
		$BG/BGLayer/Add3.modulate.a = float(Global.score - 10000) / 5000
	elif Global.score <= 20000:
		$BG/BGLayer/Add4.modulate.a = float(Global.score - 15000) / 5000

func get_type():
	var type
	var pos
	var chance = Global.RNG.randf()
	if chance < type_chances[0]:
		type = Types.PHONE
		pos = Vector2(Global.RNG.randf_range(-850, 850), Global.RNG.randf_range(-500, 450))
	elif chance >= type_chances[0] and chance < type_chances[1]:
		type = Types.BULB
		pos = Vector2(Global.RNG.randf_range(-850, 850), Global.RNG.randf_range(-1000, -700))
	elif chance >= type_chances[1] and chance < type_chances[2]:
		type = Types.MAZE
		pos = Vector2(Global.RNG.randf_range(-900, 400), Global.RNG.randf_range(-500, 0))
	elif chance >= type_chances[2] and chance < type_chances[3]:
		type = Types.BUTTONS
		pos = Vector2(Global.RNG.randf_range(-800, 700), Global.RNG.randf_range(-400, 300))
	elif chance >= type_chances[3] and chance <= type_chances[4]:
		type = Types.TIMING
		pos = Vector2(Global.RNG.randf_range(-850, 850), Global.RNG.randf_range(-500, 450))
	return [type, pos]

func show_achievement(inter_name: String):
	var new_achiv = bottom_notification.instance()
	get_node("Interface/Interface/Achievements").add_child(new_achiv)
	new_achiv.init_notif(Global.achievements[inter_name]["title"], Global.achievements[inter_name]["text"], Global.achievements[inter_name]["icon"])
	Global.play_sound("res://audio/sfx/achievement.wav")

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
		Types.TIMING:
			new_item = Timing.new()
			new_item.collider = shape
		_:
			new_item = Bulb.new()
			new_item.collider = shape
	new_item.texts = Global.items[itemname]["texts"]
	new_item.item_anim = Global.items[itemname]["icon"]
	new_item.position = pos
	new_item.type = itemname
	add_child(new_item)

func increase_type(type):
	if Global.items[type].has("win_score"):
		if type in counter:
			counter[type] += 1
		else:
			counter[type] = 1

		if counter[type] == Global.items[type]["win_score"]:
			show_achievement(Global.items[type]["win_achievement"])

func lose_score(score):
	score_lost = max(score_lost + score, 0)
	if score_lost > MAX_SCORE_LOST:
		game_over()

func game_over():
	$Normal.volume_db = -80
	$Minigame.volume_db = -80
	var gameover = over_screen.instance()
	add_child(gameover)

func _on_music_finished():
	if Global.score >= 5000:
		$Normal.stream = panic
		$Minigame.stream = panicmg
	else:
		$Normal.stream = normal
		$Minigame.stream = normalmg

	$Normal.playing = true
	$Minigame.playing = true
