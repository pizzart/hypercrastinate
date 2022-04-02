extends Node

var score: int

var items = {
	"gotyz": {
		"icon": "res://graphics/PhoneFrames.tres",
		"max_attempts": 10,
		"win_achievement": "work",
		"texts:": [
			"I'll do it tomorrow",
			"idc",
			"I'll watch anime instead"
			],
		}
	}

var achievements = {
	"work": {
		"title": "Success!",
		"text": "You got fired from you job!",
		"icon": "res://misc/gotyz.png",
		}
	}

func _ready():
	pass
