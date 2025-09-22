extends Node2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var chest: AnimatedSprite2D = $Chest
@onready var robot_head_build_battle: Sprite2D = $"../building/RobotHeadBuildBattle"

func _ready() -> void:
	visible=true

func _on_robot_body_build_battle_all_hammer_done() -> void:
	await animation_player.animation_finished
	chest.play("default")
	await get_tree().create_timer(1).timeout
	robot_head_build_battle.global_position = Vector2(2249, 485)
