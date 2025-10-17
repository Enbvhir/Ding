extends Player

var enemies_under_light:Array
var damage:float=10

@onready var sprite: Sprite2D = $Sprite2D
@onready var area_view: Area2D = $AreaView
@onready var collision_shape: CollisionPolygon2D = $AreaView/CollisionShape2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

func control(delta:float):
	if Input.is_action_pressed("mouse_left"):
		if Global.player_sing:
			var rot=(Global.player_sing.global_position-global_position).angle()
			collision_shape.rotation=rot
			point_light_2d.rotation=rot
	else:
		var rot=(get_global_mouse_position()-global_position).angle()
		collision_shape.rotation=rot
		point_light_2d.rotation=rot
	#queue_redraw()
	var vector_input=Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity=speed*vector_input.normalized()
	if dead:
		velocity=speed*2*vector_input.normalized()
		animation_player.play("RESET")
	else:
		if velocity.is_zero_approx():animation_player.play("idle")
		else:animation_player.play("walk")
	move_and_slide()
	
	if enemies_under_light.is_empty():is_atk=false
	else:is_atk=true
	for e:Enemy in enemies_under_light:
		e.hp-=damage*delta
		e.light_accumulate+=damage*delta
		if e.hp<=0:
			if e.dead:pass
			else:Global.play_sfx(Global.SFX_MONSTER_DEAD)
			e.dead=true	
			e.die()

func on_dead():
	point_light_2d.enabled=false
	area_view.monitoring=false
	enemies_under_light.clear()
func on_respawn():
	point_light_2d.enabled=true
	area_view.monitoring=true
	animation_player_2.play("respawn")

func _on_area_view_body_entered(body: Node2D) -> void:
	var e:Enemy=body
	enemies_under_light.push_back(e)


func _on_area_view_body_exited(body: Node2D) -> void:
	var e:Enemy=body
	enemies_under_light.erase(e)
