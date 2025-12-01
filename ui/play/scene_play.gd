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

const LEVEL_1 = preload("uid://ine5ls1mg6cq")
const LEVEL_2 = preload("uid://bl8x41hl8y1tu")
func switch_level(packed_level:PackedScene):
	var new_level:Level=packed_level.instantiate()
	var old_level=%Level.get_children()
	%Level.add_child(new_level)
	new_level.set_owner(%Level)
	if old_level.is_empty():pass
	else:for l in old_level:l.queue_free()
	var marks:Array=new_level.enter_point.get_children()
	if player_sing:player_sing.position=marks[0].position
	if player_view:player_view.position=marks[1].position
func switch_level_name(str_level:StringName):
	match str_level:
		"level_2":switch_level(LEVEL_2)

func _ready() -> void:
	match Global.statement_num_player:
		1:
			match Global.statement_selected_character:
				0:
					player_sing=Global.PLAYER_SING.instantiate()
					%NodePlayers.add_child(player_sing)
					Global.player_sing=player_sing
				1:
					player_view=Global.PLAYER_VIEW.instantiate()
					%NodePlayers.add_child(player_view)
		2:
			player_sing=Global.PLAYER_SING.instantiate()
			%NodePlayers.add_child(player_sing)
			Global.player_sing=player_sing
			
			player_view=Global.PLAYER_VIEW.instantiate()
			%NodePlayers.add_child(player_view)
	%HudPlayerState.set_players(player_sing,player_view)
	
	switch_level(LEVEL_1)
	
	Global.node_ammo=node_ammo
	Global.node_effect=node_effect
	Global.play_music(Global.MUSIC_PLAY)
	fail_over.connect(show_fail_ui)
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_scene(Global.SCENE_THEME)
	
	if Global.statement_num_player==2:
		camera.position=(player_view.position+player_sing.position)/2
	else:
		camera.position=%NodePlayers.get_child(0).position
	if Input.is_action_just_pressed("t"):
		var e=Global.enemies.pick_random().instantiate()
		add_child(e)
		
	if is_players_dead():
		if failed:pass
		else:
			Global.play_music(Global.MUSIC_FAIL)
			failed=true
			#canvas_modulate.visible=false
			if player_view:player_view.timer_respawn.stop()
			if player_sing:player_sing.timer_respawn.stop()
			var ui=Global.UI_JUMP_SCARE.instantiate()
			ui.enemy_id=Global.last_kill_enemy_id
			node_for_scare.add_child(ui)
	
	%FrameLight.visible=false
	if player_sing:
		if player_sing.is_atk:%FrameLight.visible=true
	if player_view:
		if player_view.is_atk:%FrameLight.visible=true

func is_players_dead()->bool:
	var is_dead=true
	for p:Player in %NodePlayers.get_children():
		if not p.is_dead:
			is_dead=false
			break
	return is_dead

func show_fail_ui():
	print("show_fail_ui")
	ui_fail.visible=true
