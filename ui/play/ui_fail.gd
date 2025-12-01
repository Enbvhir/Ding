extends Control

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	Global.switch_scene(Global.SCENE_PLAY)

func _on_button_2_pressed() -> void:
	Global.switch_scene(Global.SCENE_THEME)
