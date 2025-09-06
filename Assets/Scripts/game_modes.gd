extends Node2D
var build_battle_mouse = false
var screen_size: Vector2
var base_position: Vector2
@onready var bg_music: AudioStreamPlayer = $AudioStreamPlayer
@export var parallax_strength: float = 0.05
@onready var bg: Node2D = $bg

func _ready() -> void:
	screen_size = get_viewport().size
	base_position = bg.position
	bg_music.play(Global.intro_music_time)

func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var offset = (mouse_pos - screen_size / 2) * parallax_strength
	bg.position = base_position + offset
	
	if build_battle_mouse and Input.is_action_just_pressed("click"):
		Global.current_game = Global.games[1]

func _on_build_battle_logo_mouse_entered() -> void:
	build_battle_mouse = true

func _on_build_battle_logo_mouse_exited() -> void:
	build_battle_mouse = false
