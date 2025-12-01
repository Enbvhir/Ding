extends Player

var damage_correct:float=10
var damgae_error:float=5
var atk_stack:Array


@onready var area_damage: Area2D = $AreaDamage
@onready var timer_atk: Timer = $TimerAtk
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var light_2: Sprite2D = $Light2
@onready var animation_player_3: AnimationPlayer = $AnimationPlayer3
@onready var timer_input_reset: Timer = $TimerInputReset

func control(delta:float):
	var vector_direction=Vector2.from_angle(rotation)
	var vector_input=Input.get_vector("a","d","w","s")
	if is_dead:
		velocity=speed*2*vector_input.normalized()
		animation_player.play("RESET")
	else:
		velocity=speed*vector_input.normalized()
		if velocity.is_zero_approx():animation_player.play("idle")
		else:
			if timer_atk.is_stopped():animation_player.play("walk")
	
	move_and_slide()
	if is_dead:pass
	else:
		if area_damage.monitoring:area_damage.monitoring=false
		if timer_atk.is_stopped():
			var atk_input=0
			if Input.is_action_just_pressed("space"):
				atk_input=1
				light_2.modulate=Color.RED
				Global.play_sfx(Global.SFX_ATK_1)
			if Input.is_action_just_pressed("h"):
				atk_input=2
				light_2.modulate=Color.ORANGE
				Global.play_sfx(Global.SFX_ATK_2)
			if Input.is_action_just_pressed("j"):
				atk_input=3
				light_2.modulate=Color.YELLOW
				Global.play_sfx(Global.SFX_ATK_3)
			if Input.is_action_just_pressed("k"):
				atk_input=4
				light_2.modulate=Color.GREEN
				Global.play_sfx(Global.SFX_ATK_4)
			if Input.is_action_just_pressed("l"):
				atk_input=5
				light_2.modulate=Color.CYAN
				Global.play_sfx(Global.SFX_ATK_5)
			light_2.modulate.a=0.5
			if atk_input:
				atk_stack.push_back(atk_input)
				if atk_stack.size()>5:atk_stack.pop_front()
				timer_input_reset.start()
				area_damage.monitoring=true
				animation_player.play("atk")
				animation_player_2.play("atk_effect")
				timer_atk.start()
				is_atk=true

func _on_area_damage_body_entered(body: Node2D) -> void:
	var e:Enemy=body
	e.hp-=damage_correct
	if e.hp<=0:
		e.dead=true
		e.die()
		Global.play_sfx(Global.SFX_MONSTER_DEAD)
	else:Global.play_sfx(Global.SFX_MONSTER_HURT)

func _on_timer_atk_timeout() -> void:
	if velocity.is_zero_approx():animation_player.play("idle")
	else :animation_player.play("walk")
	is_atk=false

func _on_timer_input_reset_timeout() -> void:
	atk_stack.clear()
	
func on_respawn():
	animation_player_3.play("respawn")
