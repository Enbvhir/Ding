extends Node

const SCENE_THEME = preload("uid://d240vmenul21x")
const SCENE_PLAY = preload("uid://csresjl4ikdxf")
const SCENE_INTRO = preload("uid://vjt0qytt7k78")
const SCENE_STAFF = preload("uid://b7fhlpox4xl8h")
const SCENE_SETTINGS = preload("uid://bssclqieuko1d")
const SCENE_PASS = preload("uid://bn4yccmfxnyro")
func switch_scene(packed_scene:PackedScene):
	get_tree().call_deferred("change_scene_to_packed",packed_scene)

const SFX_ATK_1 = preload("uid://cejb4dowqril")
const SFX_ATK_2 = preload("uid://uierf60waarl")
const SFX_ATK_3 = preload("uid://dtypldmxkpip6")
const SFX_ATK_4 = preload("uid://baq2by60fw5fb")
const SFX_ATK_5 = preload("uid://d3xkasxwi2tg")
const SFX_HUMAN_DEAD = preload("uid://d7q5gmoom7o7")
const SFX_HUMAN_HURT = preload("uid://bui7g8rewm5x1")
const SFX_MONSTER_DEAD = preload("uid://cluyct7nm6sse")
const SFX_MONSTER_HURT = preload("uid://c2fxqmd8qtga0")
func play_sfx(sfx:PackedScene):%NodeSfx.add_child(sfx.instantiate())

const MUSIC_FAIL = preload("uid://6qhqdheh1mkc")
const MUSIC_PLAY =preload("uid://bakru7uu2bhpy")
const MUSIC_THEME = preload("uid://uli5ueqagtk4")
func play_music(music:AudioStream):
	%Bgm.stream=music
	%Bgm.play()
func _on_audio_stream_player_finished() -> void:%Bgm.play()

const PLAYER_SING = preload("uid://c5cxsqwbtmoxx")
const PLAYER_VIEW = preload("uid://cgg3hms7pb3iv")

enum EnemyId{
	BAT,
	BIG_EYE,
	BIG_MOUTH,
	FLOAT_HEAD,
	FROG,
	HAND_EYE,
	MAN_WOMAN,
	TWO_MOUTH,
	WORM
}

const ENEMY_BAT = preload("uid://buwh0bfare8gh")
const ENEMY_BIG_EYE = preload("uid://js4ryiq1isxr")
const ENEMY_BIG_MOUTH = preload("uid://b271c57buhqhk")
const ENEMY_FLOAT_HEAD = preload("uid://dd6c7x4q7754a")
const ENEMY_FROG = preload("uid://b4gy7t0qei81w")
const ENEMY_HAND_EYE = preload("uid://iloeg25rrcny")
const ENEMY_MAN_WOMAN = preload("uid://dcgpr0w8ifa18")
const ENEMY_MOUTH = preload("uid://djxhqfyhhkff2")
const ENEMY_WORM = preload("uid://by3yh8325fpdr")


var enemies:Array=[ENEMY_BAT,ENEMY_BIG_EYE,ENEMY_BIG_MOUTH,ENEMY_FLOAT_HEAD,
ENEMY_FROG,ENEMY_HAND_EYE,ENEMY_MAN_WOMAN,ENEMY_MOUTH,ENEMY_WORM]

const ENEMY_PIC = preload("uid://cy1ble73e38u0")
const ENEMY_PIC_BAT = preload("uid://bxluwg5e0celn")
const ENEMY_PIC_BIG_EYE = preload("uid://c3xpmlmvw0ev0")
const ENEMY_PIC_BIG_MOUTH = preload("uid://sdi2tnfffwvk")
const ENEMY_PIC_FLOAT_HEAD = preload("uid://cg7n884pl54ws")
const ENEMY_PIC_FROG = preload("uid://csxehmagujibo")
const ENEMY_PIC_HAND_EYE = preload("uid://bipcx18xbi4ns")
const ENEMY_PIC_MAN_WOMAN = preload("uid://c8vgvrtxj18bm")
const ENEMY_PIC_MOUTH = preload("uid://5igypggh3m2s")
const ENEMY_PIC_WORM = preload("uid://dst4ywl2ih28w")

var enemy_pics:Array=[ENEMY_PIC_BAT,ENEMY_PIC_BIG_EYE,ENEMY_PIC_BIG_MOUTH,ENEMY_PIC_FLOAT_HEAD,
ENEMY_PIC_FROG,ENEMY_PIC_HAND_EYE,ENEMY_PIC_MAN_WOMAN,ENEMY_PIC_MOUTH,ENEMY_PIC_WORM]

const EFFECT_DEFEAT_BLACK_1 = preload("res://elements/effect/effect_defeat_black_1.tscn")
const EFFECT_DEFEAT_BLACK_2 = preload("res://elements/effect/effect_defeat_black_2.tscn")
const EFFECT_DEFEAT_BLUE_1 = preload("res://elements/effect/effect_defeat_blue_1.tscn")
const EFFECT_DEFEAT_BLUE_2 = preload("res://elements/effect/effect_defeat_blue_2.tscn")
const EFFECT_DEFEAT_RED_1 = preload("res://elements/effect/effect_defeat_red_1.tscn")
const EFFECT_DEFEAT_RED_2 = preload("res://elements/effect/effect_defeat_red_2.tscn")

const UI_JUMP_SCARE = preload("uid://18ugjk8ni5le")

const AMMO = preload("res://elements/projectile/Ammo.tscn")


var node_ammo:Node2D
var node_effect:Node2D
var player_sing:Player

var last_kill_enemy_id
