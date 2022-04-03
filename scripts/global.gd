extends Node

signal score_updated
var score: int

var items = {
	"gotyz": {
		"icon": "res://graphics/BulbFrames.tres",
		"win_score": 10,
		"win_achievement": "work",
		"texts": [
			"I'll do it tomorrow",
			"idc",
			"I'll watch anime instead"
			],
	},
	"book": {
		"icon": "res://graphics/BookFrames.tres",
		"win_score": 3,
		"win_achievement": "stupid",
		"texts": [
			"I'll do it tomorrow",
			"stupid",
			"I'll die instead"
			],
	},
	"shower": {
		"icon": "res://graphics/ShowerFrames.tres",
		"win_score": 1000,
		"win_achievement": "stupid",
		"texts": [
			"I'll do it tomorrow",
			"stupid",
			"I'll die instead"
			],
	},
}

var achievements = {
	"work": {
		"title": "Success!",
		"text": "You got fired from your job!",
		"icon": "res://misc/gotyz.png",
	},
	"stupid": {
		"title": "Congrats!",
		"text": "You are insane!",
		"icon": "res://misc/gotyz.png",
	},
}
