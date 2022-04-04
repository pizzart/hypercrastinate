extends Node2D

var RNG = RandomNumberGenerator.new()
var pressed: int = 0
var texts = {
	"pro": 'while(true):\n           crastinate(72, "hours")',
	"sto": 'func _ready():\n          p_working()',
}
var code: String

func _ready():
	RNG.randomize()
	code = texts.keys()[RNG.randi() % texts.keys().size()]
	$Sprite/Code.text = texts[code]
	$Sprite/Replace.placeholder_text = code
	$Sprite.frame = 0
	$Sprite/Replace.grab_focus()
	yield($Sprite, "animation_finished")
	$Sprite.animation = "default"

func _on_text_changed(text: String):
	if text.to_lower() == code:
		get_parent().emit_signal("done")
