extends Enemy

func _physics_process(delta: float) -> void:
	if target:pass
	else:
		live_player_in_range=player_in_range.filter(func(p:Player):return not p.is_dead)
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
