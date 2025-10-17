extends Node2D


var failed:bool=false
var round:int=1

signal fail_over

@onready var player_view: Player = $PlayerView
@onready var player_sing: Player = $PlayerSing
@onready var camera: Camera2D = $Camera2D
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var node_for_scare: CanvasLayer = $NodeForScare
@onready var ui_fail: Control = $CanvasLayer/UiFail
@onready var node_ammo: Node2D = $NodeAmmo
@onready var node_effect: Node2D = $NodeEffect
@onready var node_generation_point: Node = $NodeGenerationPoint

func _ready() -> void:
	Global.player_view=player_view
	Global.player_sing=player_sing
	Global.players=[player_view,player_sing]
	Global.node_ammo=node_ammo
	Global.node_effect=node_effect
	Global.play_music(Global.MUSIC_PLAY)
	fail_over.connect(show_fail_ui)
	var points=node_generation_point.get_children()
	for p in points:
		var e:Enemy=Global.enemies.pick_random().instantiate()
		e.position=p.position
		add_child(e)

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

func _exit_tree() -> void:
	Global.player_view=null
	Global.player_sing=null
	Global.players.clear()

func show_fail_ui():
	print("show_fail_ui")
	ui_fail.visible=true

func _on_timer_generate_enemy_timeout() -> void:
	#for i in round:
		#var mark=node_generation_point.get_children().pick_random()
		#var e:Enemy=Global.enemies.pick_random().instantiate()
		#e.position=mark.position
		#add_child(e)
	#round+=1
	pass
