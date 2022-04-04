extends Control

var temp_score: int

func _process(delta):
	if temp_score > Global.score:
		temp_score -= 1
	elif temp_score < Global.score:
		temp_score += 1
	$Score.text = str(temp_score)
	$OverBar.value = get_parent().get_parent().score_lost
	$Panic.modulate.a = get_parent().get_parent().score_lost / get_parent().get_parent().MAX_SCORE_LOST
