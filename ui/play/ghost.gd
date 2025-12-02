extends Sprite2D

@export var amplitude := 10
@export var speed := 2.0
var base_y

func _ready():
	base_y = position.y

func _process(delta):
	if is_in_group("ghosts"):
		position.y = base_y + sin(Time.get_ticks_msec() / 300.0) * amplitude
