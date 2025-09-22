extends Sprite2D
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
signal all_hammer_done
var once = true

func _ready() -> void:
	visible=false

func _process(_delta: float) -> void:
	pass

func _on_hammer_hammer_1_finished() -> void:
	if once == true:
		await animation_player.animation_finished
		animation_player.play("body_build")
		visible=true
		await get_tree().create_timer(1.5).timeout
		animation_player.play("body_build_2")
		await animation_player.animation_finished
		animation_player.play("builder")
		await  get_tree().create_timer(2.0).timeout
		animation_player.play("after_builder")
		emit_signal("all_hammer_done")
