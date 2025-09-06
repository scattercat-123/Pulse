extends Node2D

var single_player_hover = false
var two_player_hover = false
@onready var bg_music: AudioStreamPlayer = $AudioStreamPlayer
@onready var click: AudioStreamPlayer = $AudioStreamPlayer2
@onready var scene_transition: AnimationPlayer = $"Scene transition/AnimationPlayer"
@onready var single_player: Sprite2D = $"Single/Single-player"
@onready var two_player: Sprite2D = $"two/Two-player"
@onready var single_label: Label = $Single/Label
@onready var two_label: Label = $two/Label
@onready var two_desc_label: Label = $two/Label2
@onready var single_desc_label: Label = $Single/Label2

var single_player_normal_scale: Vector2
var two_player_normal_scale: Vector2
var single_label_normal_scale: Vector2
var two_label_normal_scale: Vector2

@export var hover_multiplier: float = 1.2
@export var label_shrink: float = 0.8
@export var speed: float = 6.0

func _ready() -> void:
	scene_transition.play("recieve")
	single_player_normal_scale = single_player.scale
	two_player_normal_scale = two_player.scale
	single_label_normal_scale = single_label.scale
	two_label_normal_scale = two_label.scale
	
	bg_music.play(Global.intro_music_time)

func _process(delta: float) -> void:
	# --- siingle player ---
	var single_target_sprite = single_player_normal_scale * (hover_multiplier if single_player_hover else 1.0)
	var single_target_label = single_label_normal_scale * (label_shrink if single_player_hover else 1.0)

	single_player.scale = single_player.scale.lerp(single_target_sprite, delta * speed)
	single_label.scale = single_label.scale.lerp(single_target_label, delta * speed)

	# --- tow player ---
	var two_target_sprite = two_player_normal_scale * (hover_multiplier if two_player_hover else 1.0)
	var two_target_label = two_label_normal_scale * (label_shrink if two_player_hover else 1.0)

	two_player.scale = two_player.scale.lerp(two_target_sprite, delta * speed)
	two_label.scale = two_label.scale.lerp(two_target_label, delta * speed)
	
	if single_player_hover and Input.is_action_just_pressed("click"):
		scene_transition.play("change")
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/build_battle_singleplayer.tscn")

# signals hover
func _on_single_mouse_entered() -> void:
	click.play()
	single_player_hover = true
	single_desc_label.visible = true
func _on_single_mouse_exited() -> void:
	single_player_hover = false
	single_desc_label.visible = false

func _on_two_mouse_entered() -> void:
	click.play()
	two_player_hover = true
	two_desc_label.visible = true
func _on_two_mouse_exited() -> void:
	two_player_hover = false
	two_desc_label.visible = false
