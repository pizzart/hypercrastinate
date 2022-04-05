extends AnimatedSprite

func _ready():
	if OS.get_name() == "HTML5":
		$Sprite.show()
