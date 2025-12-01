class_name Light
extends Node2D

var is_lighted:bool=false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_lighted:return
	if body is Player:
		%AnimationPlayer.play("light")
		is_lighted=true
