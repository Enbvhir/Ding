extends Control


func _on_button_pressed() -> void:
	Global.statement_selected_character=1
	Global.switch_scene(Global.SCENE_INTRO)


func _on_button_2_pressed() -> void:
	Global.statement_selected_character=0
	Global.switch_scene(Global.SCENE_INTRO)
