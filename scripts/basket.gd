extends Node2D

func appear():
	$Sprite.play("appear")

func disappear():
	$Sprite.play("disappear")

func _on_animation_finished():
	if $Sprite.animation == "appear":
		$Sprite.play("default")
