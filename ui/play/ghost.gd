extends Sprite2D

@export var amplitude := 20
@export var fade_duration := 3.0

var base_y
var time_passed := 0.0

func _ready():
	base_y = position.y

func _process(delta):
	time_passed += delta

	position.y = base_y + sin(Time.get_ticks_msec() / 300.0) * amplitude

	var fade_phase = sin((time_passed / fade_duration) * PI) ** 2

	var min_alpha: float = 0.2
	var max_alpha: float = 1.0
	var alpha: float = lerp(min_alpha, max_alpha, fade_phase)

	self.modulate.a = alpha
