extends Enemy

var is_impact:bool =false
@onready var timer_cool: Timer = $TimerCool
@onready var timer_impact: Timer = $TimerImpact

func _physics_process(delta: float) -> void:
	if target:pass
	else:
		live_player_in_range=player_in_range.filter(func(p:Player):return not p.dead)
		if live_player_in_range.is_empty():pass
		else:target=live_player_in_range.pick_random()
	
	if is_impact:pass
	else:
		if navigation_agent_2d.is_navigation_finished():velocity=Vector2.ZERO
		else:
			var direction=to_local(navigation_agent_2d.get_next_path_position()).normalized()
			if timer_cool.is_stopped():
				velocity=direction*300
				timer_impact.start()
				is_impact=true
			else:velocity=direction*speed
	if light_accumulate>=20:
		light_accumulate-=20
		Global.play_sfx(Global.SFX_MONSTER_HURT)
	move_and_slide()

func _on_timer_impact_timeout() -> void:
	is_impact=false
	timer_cool.start()
