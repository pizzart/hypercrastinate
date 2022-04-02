extends Item

var size = 0
var grow_mult = 0.1
var MAXSIZE = 1

func _ready():
	pass

func _process(delta):
	size += delta * grow_mult
	spr.scale = Vector2(size, size)

	if ( size > MAXSIZE ):
		end_minigame()

