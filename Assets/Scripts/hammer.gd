extends AnimatedSprite2D
signal hammer_1_finished
var once = false

func _ready() -> void:
	visible = false

func _on_static_body_2d_area_entered(_area: Area2D) -> void:
	visible = true
	play("hammer")
	await animation_finished
	if once == false:
		emit_signal("hammer_1_finished")
		once = true
