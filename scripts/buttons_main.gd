extends Node2D

var pressed: int = 0
var texts = {
	"pro": 'while(true):\n           crastinate(72, "hours")',
	"sto": 'func _ready():\n          p_working()',
	"va": 'func describe():\n         r lazy = true',
}
var code: String

func _ready():
	code = texts.keys()[Global.RNG.randi() % texts.keys().size()]
	$Sprite/Code.text = texts[code]
	$Sprite/Replace.placeholder_text = code
	$Sprite/Replace.max_length = len(code)
	$Sprite.frame = 0
	$Sprite/Replace.grab_focus()
	yield($Sprite, "animation_finished")
	$Sprite.animation = "default"

func _on_text_changed(text: String):
	if text.to_lower() == code:
		get_parent().emit_signal("done")
		$Sprite/Replace.editable = false
