extends Control

@onready var h_scroll_bar_music: HScrollBar = $HScrollBarMusic
@onready var h_scroll_bar_sfx: HScrollBar = $HScrollBarSfx
@onready var area_2d: Area2D = $Area2D
@onready var area_2d_2: Area2D = $Area2D2

func _physics_process(delta: float) -> void:
	area_2d_2.position=get_local_mouse_position()
	if Input.is_action_just_pressed("esc")\
	or (Input.is_action_just_pressed("mouse_left") and area_2d.overlaps_area(area_2d_2)):
		Global.switch_scene(Global.SCENE_THEME)
	
func _on_h_scroll_bar_music_scrolling() -> void:
	var index=AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(index,h_scroll_bar_music.value)

func _on_h_scroll_bar_sfx_scrolling() -> void:
	var index=AudioServer.get_bus_index("Sfx")
	AudioServer.set_bus_volume_linear(index,h_scroll_bar_sfx.value)
