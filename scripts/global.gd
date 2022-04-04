extends Node

signal score_updated
var score: int
var mus_vol: float
var sfx_vol: float
var try_tutorial: bool
var RNG = RandomNumberGenerator.new()

var items = {
	"gotyz": {
		"icon": "res://graphics/BulbFrames.tres",
		"win_score": 10,
		"win_achievement": "darkness",
		"texts": [
			"I'll fix it later",
			"Not a big issue",
			"Too busy GAMING",
			"My monitor has light anyways",
			],
	},
	"book": {
		"icon": "res://graphics/BookFrames.tres",
		"win_score": 5,
		"win_achievement": "stupid",
		"texts": [
			"I'll read it tomorrow",
			"Who needs them anyways?",
			"It's so boring",
			"I'd rather watch Netfliks",
			],
	},
	"shower": {
		"icon": "res://graphics/ShowerFrames.tres",
		"win_score": 10,
		"win_achievement": "grease",
		"texts": [
			"I'll do it in a few minutes",
			"Who cares?",
			"Waste of time",
			"Gamers don't need showers",
			],
	},
	"can": {
		"icon": "res://graphics/CanFrames.tres",
		"win_score": 10,
		"win_achievement": "obese",
		"texts": [
			"A nice boost",
			"Soft and refreshing",
			],
	},
	"shirt": {
		"icon": "res://graphics/ShirtFrames.tres",
		"win_score": 5,
		"win_achievement": "stock",
		"texts": [
			"I can always wash it later",
			"Why'd I need to change clothes",
			],
	},
}

var achievements = {
	"work": {
		"title": "Successful career",
		"text": "You got fired!",
		"icon": "res://graphics/achievements/smart.png",
	},
	"stupid": {
		"title": "Smarty pants",
		"text": "You're evolving, just backwards",
		"icon": "res://graphics/achievements/smart.png",
	},
	"grease": {
		"title": "Stinky",
		"text": "You haven't showered in 2 weeks!",
		"icon": "res://graphics/achievements/stink.png",
	},
	"darkness": {
		"title": "Dark cave",
		"text": "You're living in total darkness!",
		"icon": "res://graphics/achievements/dark.png",
	},
	"obese": {
		"title": "Rebbit Moderator",
		"text": "You've gained 100 pounds!",
		"icon": "res://graphics/achievements/fat.png",
	},
	"stock": {
		"title": "I'll take your entire stock",
		"text": "Your bedroom is now a t-shirt storage!",
		"icon": "res://graphics/achievements/stock.png",
	},
}

func _ready():
	RNG.randomize()
	connect("tree_exiting", self, "_on_tree_exiting")
	mus_vol = load_conf("volume", "music", 0.25)
	sfx_vol = load_conf("volume", "sound", 0.25)
	AudioServer.set_bus_volume_db(1, linear2db(mus_vol))
	AudioServer.set_bus_volume_db(2, linear2db(sfx_vol))

func play_sound(path: String):
	var stream = load(path)
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.autoplay = true
	player.bus = "Sounds"
	add_child(player)

func save_conf(section, key, val):
	var config = ConfigFile.new()
	config.load("user://hyper.cfg")
	config.set_value(section, key, val)
	config.save("user://hyper.cfg")

func load_conf(section, key, default):
	var config = ConfigFile.new()
	var err = config.load("user://hyper.cfg")
	if err != OK:
		return 0
	return config.get_value(section, key, default)

func _on_tree_exiting():
	Global.save_conf("volume", "music", db2linear(AudioServer.get_bus_volume_db(1)))
	Global.save_conf("volume", "sound", db2linear(AudioServer.get_bus_volume_db(2)))
