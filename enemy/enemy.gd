class_name Enemy
extends CharacterBody2D
@export var id:Global.EnemyId=0
@export var hp:float=100
@export var speed:float=100
@export var atk:float=50

var player_in_range:Array
var live_player_in_range:Array
var target:Player=null
var dead:bool=false
var light_accumulate:float
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if target:pass
	else:
		live_player_in_range=player_in_range.filter(func(p:Player):return not p.dead)
		if live_player_in_range.is_empty():pass
		else:target=live_player_in_range.pick_random()
	
	if navigation_agent_2d.is_navigation_finished():velocity=Vector2.ZERO
	else:
		var direction=to_local(navigation_agent_2d.get_next_path_position()).normalized()
		velocity=direction*speed
	
	if light_accumulate>=20:
		light_accumulate-=20
		Global.play_sfx(Global.SFX_MONSTER_HURT)
	move_and_slide()


func _on_area_2d_range_body_entered(body: Node2D) -> void:
	player_in_range.push_back(body)

func _on_area_2d_range_body_exited(body: Node2D) -> void:
	player_in_range.erase(body)
	if target==body:target=null

func _on_timer_check_timeout() -> void:
	if target:
		if target.dead:
			target=null
			return
		navigation_agent_2d.target_position=target.position

var group1=[Global.EnemyId.BAT,Global.EnemyId.FROG,Global.EnemyId.BIG_EYE]
var group2=[Global.EnemyId.BIG_MOUTH,Global.EnemyId.TWO_MOUTH,Global.EnemyId.HAND_EYE]
var group3=[Global.EnemyId.FLOAT_HEAD,Global.EnemyId.WORM,Global.EnemyId.MAN_WOMAN]
func die()->void:
	dead=true
	animation_player.play("die")
	var char=null
	if id in group1:char=Global.EFFECT_DEFEAT_BLUE_1.instantiate()
	if id in group2:char=Global.EFFECT_DEFEAT_RED_1.instantiate()
	if id in group3:char=Global.EFFECT_DEFEAT_BLACK_1.instantiate()
	if char:
		char.position=position
		Global.node_effect.add_child(char)
