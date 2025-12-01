extends Enemy

@onready var timer_charge: Timer = $TimerCharge
@onready var timer_impact: Timer = $TimerImpact
func _physics_process(delta: float) -> void:
	if target:pass
	else:
		live_player_in_range=player_in_range.filter(func(p:Player):return not p.is_dead)
		if live_player_in_range.is_empty():pass
		else:target=live_player_in_range.pick_random()
	
	if timer_impact.is_stopped():
		if target:
			if timer_charge.is_stopped():
				velocity=Vector2.ZERO
				timer_charge.start()
	if light_accumulate>=20:
		light_accumulate-=20
		Global.play_sfx(Global.SFX_MONSTER_HURT)	
	move_and_slide()
	
	#print(velocity,",",target)

func _on_timer_charge_timeout() -> void:
	var direction=to_local(navigation_agent_2d.get_next_path_position()).normalized()
	velocity=direction*300
	print("发射")
	timer_impact.start()

func _on_timer_impact_timeout() -> void:
	velocity=Vector2.ZERO
