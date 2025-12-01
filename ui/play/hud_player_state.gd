class_name HudPlayerState
extends Control

@onready var bar_back_view: TextureProgressBar = $PlayerStateView/BarBack
@onready var bar_view: TextureProgressBar = $PlayerStateView/Bar
@onready var head_pic_view: Sprite2D = $PlayerStateView/HeadPic
@onready var bar_back_sing: TextureProgressBar = $PlayerStateSing/BarBack
@onready var bar_sing: TextureProgressBar = $PlayerStateSing/Bar
@onready var head_pic_sing: Sprite2D = $PlayerStateSing/HeadPic
var player_sing:Player=null
var player_view:Player=null

func _process(delta: float) -> void:
	if player_view:
		bar_view.value=player_view.hp
		if bar_back_view.value==bar_view.value:pass
		else:bar_back_view.value=move_toward(bar_back_view.value,bar_view.value,50*delta)
		if player_view.is_dead:head_pic_view.region_rect=Rect2(30,938,346,417)
		else:
			if player_view.is_atk:head_pic_view.region_rect=Rect2(30,485,346,417)
			else:head_pic_view.region_rect=Rect2(30,26,346,417)
	
	if player_sing:
		bar_sing.value=player_sing.hp
		if bar_back_sing.value==bar_sing.value:pass
		else:bar_back_sing.value=move_toward(bar_back_sing.value,bar_sing.value,100*delta)
		if player_sing.is_dead:head_pic_sing.region_rect=Rect2(422,942,345,417)
		else:
			if player_sing.is_atk:head_pic_sing.region_rect=Rect2(422,489,345,417)
			else:head_pic_sing.region_rect=Rect2(422,30,345,417)

func set_players(sing:Player,view:Player):
	player_sing=sing
	player_view=view
	if player_sing==null:%PlayerStateSing.visible=false
	if player_view==null:%PlayerStateView.visible=false
