extends Enemy

@onready var timer_cool: Timer = $TimerCool
@onready var marker_2d: Marker2D = $Marker2D

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
	
	#if target:
		#if timer_cool.is_stopped():
			#var a=Global.AMMO.instantiate()
			#a.velocity=(target.global_position-global_position).normalized()*40
			#a.global_position=marker_2d.global_position
			#Global.node_ammo.add_child(a)
			#timer_cool.start()
	#
	#if Input.is_action_just_pressed("mouse_left"):
		#var a=Global.AMMO.instantiate()
		#a.velocity=Vector2.ZERO
		#a.position=get_local_mouse_position()
		#Global.node_ammo.add_child(a)
		#print(get_global_mouse_position())
	if light_accumulate>=20:
		light_accumulate-=20
		Global.play_sfx(Global.SFX_MONSTER_HURT)
	move_and_slide()
