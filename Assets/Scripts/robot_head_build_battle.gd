extends Sprite2D
@onready var hammer: AnimatedSprite2D = $"../../hammer"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var assembly: Node2D = $"../../Assembly"
@onready var assembly_camera: Camera2D = $"../assembly_camera"
@onready var camera_2d: Camera2D = $"../../../Orange/Camera2D"

func _ready() -> void:
	visible = false

func _on_assembly_assembly_done() -> void:
	Dialogic.start("after_assembly_build_battle")
	hammer.visible = true
	visible = true
	assembly.visible = false
	animation_player.play("head_build")


func _on_hammer_hammer_1_finished() -> void:
	animation_player.play("head_build_2")
