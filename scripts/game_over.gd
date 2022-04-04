extends Control

var moving: bool

func _ready():
	Pause.disabled = true
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

func _on_back():
	Global.score = 0
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Menu.tscn")

func _on_again():
	Global.score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_again_tutorial():
	Global.score = 0
	get_tree().paused = false
	Global.try_tutorial = true
	get_tree().reload_current_scene()
