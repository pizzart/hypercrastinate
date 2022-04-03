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
}

var achievements = {
	"work": {
		"title": "Successful career",
		"text": "You got fired from your job!",
		"icon": "res://misc/gotyz.png",
	},
	"stupid": {
		"title": "Smarty pants",
		"text": "You've got a single braincell left!",
		"icon": "res://misc/gotyz.png",
	},
	"grease": {
		"title": "Stinky",
		"text": "You haven't showered in 2 weeks!",
		"icon": "res://misc/gotyz.png",
	},
	"darkness": {
		"title": "Dark cave",
		"text": "You're living in darkness!",
		"icon": "res://misc/gotyz.png",
	},
}

func play_sound(path: String):
	var stream = load(path)
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.autoplay = true
	player.bus = "Sounds"
	add_child(player)
