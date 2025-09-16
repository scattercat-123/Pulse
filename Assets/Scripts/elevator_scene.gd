extends Node2D
@onready var scene_transition: AnimationPlayer = $"Scene transition/AnimationPlayer"

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	Dialogic.start("racoon_build_battle")
	Global.dialogue_is_top = true
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended() -> void:
	await get_tree().create_timer(2.0).timeout
	scene_transition.play("change")
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Assets/Scenes/build_battle_singleplayer.tscn")
