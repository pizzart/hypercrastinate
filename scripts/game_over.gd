extends Control

var moving: bool

func _ready():
	rect_position.y = -1080
	get_tree().paused = true
	$M/V/Score.text = "Your score: %s" % Global.score
	yield(get_tree().create_timer(0.5), "timeout")
	$Sound.play()
	moving = true

func _process(delta):
	if moving:
		rect_position = rect_position.linear_interpolate(Vector2(0, 0), delta * 5)
