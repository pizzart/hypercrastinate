extends Panel

onready var title = get_node("HBox/VBox/Title")
onready var text = get_node("HBox/VBox/Text")
onready var icon = get_node("HBox/Icon")

func _ready():
	pass

func init(title_in, text_in, icon_in):
	title.text = title_in 
	text.text = text_in 
	icon.texture.load_path = icon_in

func _on_Timer_timeout():
	queue_free()
