extends Sprite2D
@onready var hover: AudioStreamPlayer = $"../../AudioStreamPlayer"
@export var hover_multiplier: float = 1.05
@export var speed: float = 6.0
@onready var bg_music: AudioStreamPlayer = $"../../../AudioStreamPlayer"

var normal_scale: Vector2
var target_scale: Vector2
var mouse = false

func _ready() -> void:
	normal_scale = scale
	target_scale = normal_scale

func _process(delta: float) -> void:
	scale = scale.lerp(target_scale, delta * speed)
	if mouse == true and Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_file("res://Assets/Scenes/game_mode.tscn")
		Global.intro_music_time = bg_music.get_playback_position()

func _on_area_2d_mouse_entered() -> void:
	mouse = true
	target_scale = normal_scale * hover_multiplier
	hover.play()

func _on_area_2d_mouse_exited() -> void:
	target_scale = normal_scale
	mouse = false
