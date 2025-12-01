extends Area2D

@export var target_level:String
@export var level_enter_point_order:int

func _on_body_entered(body: Node2D) -> void:
	if target_level:
		if body is Player:
			var level:Level=get_parent()
			if level==null:return
			var node_level:Node2D=level.get_parent()
			if node_level==null:return
			node_level.get_parent().switch_level_name(target_level)
