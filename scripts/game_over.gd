extends Control

var moving: bool

func _ready():
	rect_position.y = -1080
	get_tree().paused = true
	$M/V/Score.text = "Your score: %s" % Global.score
	var prev_score = Global.load_conf("game", "highscore", 0)
	if Global.score > prev_score:
		$M/V/Beaten.text = "You have a new high score!"
		Global.save_conf("game", "highscore", Global.score)
	else:
		$M/V/Beaten.text = "You did not beat your high score: %s" % prev_score
	yield(get_tree().create_timer(0.5), "timeout")
	$Sound.play()
	moving = true

func _process(delta):
	if moving:
		rect_position = rect_position.linear_interpolate(Vector2(0, 0), delta * 5)
