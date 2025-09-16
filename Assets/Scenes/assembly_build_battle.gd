extends Node2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var card_swipe: Node2D = $"../card_swipe"
@onready var robot_head: Sprite2D = $RobotHeadBuildBattle
@onready var robot_body: Sprite2D = $RobotBodyBuildBattle
@onready var body_outline: Sprite2D = $RobotBodyBuildBattleOutline
@onready var head_outline: Sprite2D = $RobotHeadBuildBattleOutline
@onready var instruction: Label = $Label3
@onready var submit_button: Sprite2D = $"Submit-button"
@onready var correct: AudioStreamPlayer = $"../SFX/correct"

var card_done = false
var dragging_head = false
var dragging_body = false
var head_hover = false
var body_hover = false
var head_pos = false
var body_pos = false
var submit_button_hover = false
var play_once = false

func _process(_delta: float) -> void:
	if not card_done:
		return
	
	var camera: Camera2D = get_viewport().get_camera_2d()

	if Input.is_action_just_pressed("click"):
		if head_hover:
			dragging_head = true
		elif body_hover:
			dragging_body = true
			
	if head_pos and body_pos:
		if Input.is_action_just_pressed("click") and submit_button_hover == true:
			animation_player.play("assembly_exit")
			instruction.text = ("Parts loading complete.")
			if play_once == false:
				correct.play()
				play_once = true
		else:
			instruction.text = ("Great! Click submit to start production.")
		submit_button.visible = true
		

	if Input.is_action_pressed("click"):
		if dragging_head and head_pos == false:
			robot_head.global_position = camera.get_global_mouse_position()
		elif dragging_body and body_pos == false:
			robot_body.global_position = camera.get_global_mouse_position()

	if Input.is_action_just_released("click"):
		if dragging_head:
			dragging_head = false
		elif dragging_body:
			dragging_body = false

func _on_card_swipe_card_swiped_granted() -> void:
	animation_player.play("accepted_swipe")
	await get_tree().create_timer(1.0).timeout
	card_swipe.visible = false
	visible = true
	animation_player.play("assembly_enter")
	card_done = true
	
func _on_body_mouse_entered() -> void:
	body_hover = true

func _on_body_mouse_exited() -> void:
	body_hover = false

func _on_head_mouse_entered() -> void:
	head_hover = true

func _on_head_mouse_exited() -> void:
	head_hover = false



func _on_body_outline_area_entered(area: Area2D) -> void:
	robot_body.global_position = body_outline.global_position
	body_pos = true



func _on_head_outline_area_entered(area: Area2D) -> void:
	robot_head.global_position = head_outline.global_position
	head_pos = true


func _on_submit_mouse_entered() -> void:
	submit_button_hover = true

func _on_submit_mouse_exited() -> void:
	submit_button_hover = false
