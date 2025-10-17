extends Control

@export var  enemy_id:int=0
@onready var node_2d: Node2D = $Node2D
func _ready() -> void:
	var enemy_pic=Global.enemy_pics[enemy_id].instantiate()
	node_2d.add_child(enemy_pic)

func emit_end_signal():
	print("emit_end_signal")
	var f= get_parent().get_parent()
	if f:
		f.emit_signal("fail_over")
		print("emit_end_signal to father")
	
