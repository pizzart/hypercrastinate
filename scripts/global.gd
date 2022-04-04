extends Node

signal score_updated
var score: int

var items = {
	"gotyz": {
		"icon": "res://graphics/BulbFrames.tres",
		"win_score": 10,
		"win_achievement": "darkness",
		"texts": [
			"I'll fix it later",
			"Not a big issue",
			"I'm too busy with games right now",
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
			"I'd rather watch a movie",
			],
	},
	"shower": {
		"icon": "res://graphics/ShowerFrames.tres",
		"win_score": 10,
		"win_achievement": "grease",
		"texts": [
			"I'll do it in a few minutes",
			"Who cares? I'm alone",
			"Waste of time",
			"I'm a gamer, I don't need showers",
			],
	},
	"can": {
		"icon": "res://graphics/CanFrames.tres",
		"win_score": 10,
		"win_achievement": "obese",
		"texts": [
			"A nice boost",
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
		"text": "You got fired from your job!",
		"icon": "res://graphics/achievements/smart.png",
	},
	"stupid": {
		"title": "Smarty pants",
		"text": "You've got a single braincell left!",
		"icon": "res://graphics/achievements/smart.png",
	},
	"grease": {
		"title": "Stinky",
		"text": "You haven't showered in 2 weeks!",
		"icon": "res://graphics/achievements/stink.png",
	},
	"darkness": {
		"title": "Dark cave",
		"text": "You're living in darkness!",
		"icon": "res://graphics/achievements/dark.png",
	},
	"obese": {
		"title": "Moderator",
		"text": "You've gained 100 pounds!",
		"icon": "res://graphics/achievements/fat.png",
	},
	"stock": {
		"title": "I'll take your entire stock",
		"text": "You've got some stock!",
		"icon": "res://graphics/achievements/stock.png",
	},
}

func play_sound(path: String):
	var stream = load(path)
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.autoplay = true
	player.bus = "Sounds"
	add_child(player)

func save_conf(section, key, val):
	var config = ConfigFile.new()
	config.set_value(section, key, val)
	config.save("user://swgame-ld50.cfg")

func load_conf(section, key, default):
	var config = ConfigFile.new()
	var err = config.load("user://swgame-ld50.cfg")
	if err != OK:
		return 0
	return config.get_value(section, key, default)
