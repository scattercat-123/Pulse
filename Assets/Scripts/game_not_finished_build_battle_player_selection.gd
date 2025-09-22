extends Control

var redirect := 10
@onready var timer: Timer = $Timer
@onready var label: Label = $Label3
@onready var area_2d: Area2D = $ColorRect2/Area2D
var hover = false

func _ready() -> void:
	label.text = "This page automatically redirects in %d" % redirect
	timer.wait_time = 1.0
	timer.start()
	timer.timeout.connect(_on_timer_timeout)  # make sure signal is connected in code

func _on_timer_timeout() -> void:
	redirect -= 1
	if redirect > 0:
		label.text = "This page automatically redirects in %d" % redirect
	else:
		timer.stop()
		label.text = "Redirecting now..."
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/modes.tscn")
		

func _process(delta: float) -> void:
	if hover and Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_file("res://Assets/Scenes/modes.tscn")

func _on_area_2d_mouse_entered() -> void:
	hover = true


func _on_area_2d_mouse_exited() -> void:
	hover = false
