extends Node2D

var build_battle_mouse = false
var screen_size: Vector2
var base_position: Vector2

@onready var click: AudioStreamPlayer = $AudioStreamPlayer2
@onready var bg_music: AudioStreamPlayer = $AudioStreamPlayer
@export var parallax_strength: float = 0.05
@onready var bg: Node2D = $bg
@onready var build_battle: Sprite2D = $"Build-Battle/Build Battle logo/Build-battle"
@onready var scene_transition: AnimationPlayer = $"Scene transition/AnimationPlayer"

var build_battle_normal_scale: Vector2
@export var hover_multiplier: float = 1.1
@export var speed: float = 6.0

func _ready() -> void:
	screen_size = get_viewport().size
	base_position = bg.position
	bg_music.play(Global.intro_music_time)

	build_battle_normal_scale = build_battle.scale
	scene_transition.play("recieve")

func _process(delta: float) -> void:
	# bg parallax
	var mouse_pos = get_viewport().get_mouse_position()
	var offset = (mouse_pos - screen_size / 2) * parallax_strength
	bg.position = base_position + offset

	if build_battle_mouse:
		# zoom in
		var target_sprite = build_battle_normal_scale * hover_multiplier
		build_battle.scale = build_battle.scale.lerp(target_sprite, delta * speed)
		if Input.is_action_just_pressed("click"):
			Global.current_game = Global.games[1]
			scene_transition.play("change")
			await get_tree().create_timer(1.4).timeout
			get_tree().change_scene_to_file("res://Assets/Scenes/modes.tscn")
			Global.intro_music_time = bg_music.get_playback_position()
	else:
		# zoom back
		build_battle.scale = build_battle.scale.lerp(build_battle_normal_scale, delta * speed)

# signals for hover
func _on_build_battle_logo_mouse_entered() -> void:
	build_battle_mouse = true
	click.play()

func _on_build_battle_logo_mouse_exited() -> void:
	build_battle_mouse = false
