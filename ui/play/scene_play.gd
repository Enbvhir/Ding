extends Control

var failed:bool=false
var player_sing:Player
var player_view:Player

signal fail_over

@onready var camera: Camera2D = $Camera2D
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var node_for_scare: CanvasLayer = $NodeForScare
@onready var ui_fail: Control = $CanvasLayer/UiFail
@onready var node_ammo: Node2D = $NodeAmmo
@onready var node_effect: Node2D = $NodeEffect
@onready var node_generation_point: Node = $NodeGenerationPoint
@onready var bar_back_view: TextureProgressBar = $Hud/PlayerStateView/BarBack
@onready var bar_view: TextureProgressBar = $Hud/PlayerStateView/Bar
@onready var head_pic_view: Sprite2D = $Hud/PlayerStateView/HeadPic
@onready var bar_back_sing: TextureProgressBar = $Hud/PlayerStateSing/BarBack
@onready var bar_sing: TextureProgressBar = $Hud/PlayerStateSing/Bar
@onready var head_pic_sing: Sprite2D = $Hud/PlayerStateSing/HeadPic
@onready var level_1: Level = $Level/Level1

func _ready() -> void:
	var marks:Array=level_1.enter_point.get_children()
	
	player_sing=Global.PLAYER_SING.instantiate()
	player_sing.position=marks[0].position
	%NodePlayers.add_child(player_sing)
	Global.player_sing=player_sing
	
	player_view=Global.PLAYER_VIEW.instantiate()
	player_view.position=marks[1].position
	%NodePlayers.add_child(player_view)
	
	Global.node_ammo=node_ammo
	Global.node_effect=node_effect
	Global.play_music(Global.MUSIC_PLAY)
	fail_over.connect(show_fail_ui)
	var points=node_generation_point.get_children()
	for p in points:
		var e:Enemy=Global.enemies.pick_random().instantiate()
		e.position=p.position
		add_child(e)

func _process(delta: float) -> void:
	bar_view.value=player_view.hp
	if bar_back_view.value==bar_view.value:pass
	else:bar_back_view.value=move_toward(bar_back_view.value,bar_view.value,100*delta)
	if player_view.dead:head_pic_view.region_rect=Rect2(30,938,346,417)
	else:
		if player_view.is_atk:head_pic_view.region_rect=Rect2(30,485,346,417)
		else:head_pic_view.region_rect=Rect2(30,26,346,417)
	
	bar_sing.value=player_sing.hp
	if bar_back_sing.value==bar_sing.value:pass
	else:bar_back_sing.value=move_toward(bar_back_sing.value,bar_sing.value,100*delta)
	if player_sing.dead:head_pic_sing.region_rect=Rect2(422,942,345,417)
	else:
		if player_sing.is_atk:head_pic_sing.region_rect=Rect2(422,489,345,417)
		else:head_pic_sing.region_rect=Rect2(422,30,345,417)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_scene(Global.SCENE_THEME)
	
	camera.position=(player_view.position+player_sing.position)/2
	
	if Input.is_action_just_pressed("t"):
		var e=Global.enemies.pick_random().instantiate()
		add_child(e)
		
	if player_view.dead && player_sing.dead:
		if failed:pass
		else:
			Global.play_music(Global.MUSIC_FAIL)
			failed=true
			#canvas_modulate.visible=false
			player_view.timer_respawn.stop()
			player_view.timer_respawn.stop()
			var ui=Global.UI_JUMP_SCARE.instantiate()
			ui.enemy_id=Global.last_kill_enemy_id
			node_for_scare.add_child(ui)

func show_fail_ui():
	print("show_fail_ui")
	ui_fail.visible=true
