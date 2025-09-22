extends CharacterBody2D
class_name Orange
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_in_stairs = false
var direction = 0
@onready var camera: Camera2D = $Camera2D
@onready var card_swipe: Node2D = $"../game_gui/card_swipe"
@onready var camera_card: Camera2D = $"../game_gui/card_swipe/Camera2D"

func _ready() -> void:
	card_swipe.visible = false
	Dialogic.signal_event.connect(signaling)
	Dialogic.VAR.head = Global.build_battle_robot_head_box_entered
	Dialogic.start("build_battle_tutorial")
	Global.build_battle_robot_head_box_entered = false
	Dialogic.VAR.body = Global.build_battle_robot_body_entered
	camera.make_current()

func signaling(arg):
	if arg == "intro_build_battle_tutorial":
		Global.build_battle_tutorial = true
	if arg == "continue_after_head_collected":
		Global.build_battle_continue_after_head = true

func _process(_delta: float) -> void:
	if Global.build_battle_tutorial:
		Global.build_battle_robot_can_move = true
	else:
		Global.build_battle_robot_can_move = false

func _physics_process(delta: float) -> void:
	# gravity
	if Global.build_battle_robot_can_move:
		if not is_on_floor():
			velocity += get_gravity() * delta
		# jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if player_in_stairs:
			var direction_y := Input.get_axis("move_up", "move_down")
			velocity.y = direction_y * SPEED
		move_and_slide()
	

func _on_stairs_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_stairs = true
		velocity.y = 0

func _on_stairs_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_stairs = false
		velocity.y = 0

func _on_box_robot_head_body_entered(_body: Node2D) -> void:
	if Global.build_battle_robot_head_box_entered == false:
		Global.build_battle_robot_head_box_entered = true
		Dialogic.VAR.head = Global.build_battle_robot_head_box_entered
		Dialogic.start("build_battle_tutorial_2")
	
	
func _on_box_robot_body_body_entered(body: Node2D) -> void:
	if Global.build_battle_continue_after_head and Global.build_battle_robot_body_entered == false:
		Global.build_battle_robot_body_entered = true
		Dialogic.VAR.body = Global.build_battle_robot_body_entered
		Dialogic.start("build_battle_tutorial_3")


func _on_area_2d_body_entered(_body: Node2D) -> void: # for card swiper
	if Global.build_battle_robot_body_entered and Global.screen_approached == false:
		Global.screen_approached = true
		card_swipe.visible = true
		camera_card.global_position = camera.global_position
		camera_card.make_current()
		Global.dialogue_is_top = true
		Dialogic.VAR.screen = Global.screen_approached
		Global.build_battle_robot_can_move = false
		Dialogic.start("build_battle_tutorial_4")
