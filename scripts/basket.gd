extends Node2D

func appear():
	$BasketArea/CollisionShape2D.disabled = false
	$Sprite.play("appear")

func disappear():
	$Sprite.play("disappear")

func _on_animation_finished():
	if $Sprite.animation == "appear":
		$Sprite.play("default")
	if $Sprite.animation == "disappear":
		$BasketArea/CollisionShape2D.disabled = true
