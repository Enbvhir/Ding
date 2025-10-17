extends Control

func _ready() -> void:
	Global.play_music(Global.MUSIC_THEME)

func _on_button_pressed() -> void:Global.switch_scene(Global.SCENE_INTRO)

func _on_button_2_pressed() -> void:get_tree().quit()

func _on_button_3_pressed() -> void:Global.switch_scene(Global.SCENE_SETTINGS)

func _on_button_4_pressed() -> void:Global.switch_scene(Global.SCENE_STAFF)
