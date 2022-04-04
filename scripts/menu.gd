extends Control

func _ready():
	$CanvasLayer/Margin/H/V/Music/Slider.value = Global.mus_vol
	$CanvasLayer/Margin/H/V/Sounds/Slider.value = Global.sfx_vol
	Pause.disabled = true

func _on_started():
	Global.play_sound("res://audio/sfx/click.wav")
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_exited():
	Global.play_sound("res://audio/sfx/click.wav")
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().quit()

func _on_music_changed(value: float):
	AudioServer.set_bus_volume_db(1, linear2db(value))

func _on_sound_changed(value: float):
	AudioServer.set_bus_volume_db(2, linear2db(value))

func _on_music_input(event: InputEvent):
	if event.is_action_released("start_minigame"):
		Global.save_conf("volume", "music", db2linear(AudioServer.get_bus_volume_db(1)))

func _on_sound_input(event: InputEvent):
	if event.is_action_released("start_minigame"):
		Global.save_conf("volume", "sound", db2linear(AudioServer.get_bus_volume_db(2)))
