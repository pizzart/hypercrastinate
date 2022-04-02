extends Control

func _ready():
	Global.connect("score_updated", self, "_on_score_updated")

func _on_score_updated():
	$Score.text = str(Global.score)
