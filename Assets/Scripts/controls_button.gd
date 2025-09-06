extends Sprite2D

@onready var hover: AudioStreamPlayer = $"../../AudioStreamPlayer"
@export var hover_multiplier: float = 1.05
@export var speed: float = 6.0

var normal_scale: Vector2
var target_scale: Vector2

func _ready() -> void:
	normal_scale = scale
	target_scale = normal_scale

func _process(delta: float) -> void:
	scale = scale.lerp(target_scale, delta * speed)

func _on_controls_button_area_mouse_entered() -> void:
	target_scale = normal_scale * hover_multiplier
	hover.play()

func _on_controls_button_area_mouse_exited() -> void:
	target_scale = normal_scale
