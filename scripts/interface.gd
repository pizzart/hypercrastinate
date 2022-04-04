extends Control

var upping: bool
var temp_score: int

func _ready():
	Global.connect("score_updated", self, "_on_score_updated")

func _process(delta):
	if temp_score == Global.score:
		upping = false
	else:
		temp_score += 1
	$Score.text = str(temp_score)
	$OverBar.value = get_parent().get_parent().score_lost

func _on_score_updated():
	upping = true
