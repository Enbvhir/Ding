extends Control

var is_ready:bool=false
var order:int=0
var intros:Array
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

func _ready() -> void:
	intros=[$Intro, $Intro2, $Intro3, $Intro4, $Intro5, $Intro6, $Intro7, $Intro8]

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_scene(Global.SCENE_PLAY)
	if is_ready:
		if Input.is_action_just_pressed("space"):
			if order<8:
				intros[order].visible=true
				order+=1
			else:
				animation_player.play("end")

func ready():
	is_ready=true
	animation_player_2.play("loop")

func end():Global.switch_scene(Global.SCENE_PLAY)
