extends Control

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_scene(Global.SCENE_THEME)


func _on_button_pressed() -> void:Global.switch_scene(Global.SCENE_THEME)
