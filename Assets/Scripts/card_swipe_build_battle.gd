extends Node2D

@onready var card: Sprite2D = $Card
@onready var wallet: Sprite2D = $Wallet
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var text_swiper: Label = $text_swiper
@onready var animation_player_main: AnimationPlayer = $"../AnimationPlayer"
@onready var card_swipe: Node2D = $"."
@onready var access_granted: AudioStreamPlayer = $"../SFX/access_granted"
@onready var acces_denied: AudioStreamPlayer = $"../SFX/acces_denied"
@onready var assembly: Node2D = $"../Assembly"

signal card_swiped_granted

var cardd = false
var wallet_hovering: bool = false
var once: bool = false
var hover: bool = false
var is_swiping: bool = false

var velocities: Array = []            # stores Vector2 frame velocities
var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var prev_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	card.visible = false
	wallet.visible = false
	assembly.visible = false

func _process(_delta: float) -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()

	if Input.is_action_just_pressed("click") and hover and once:
		is_dragging = true
		drag_offset = card.global_position - camera.get_global_mouse_position()
		prev_pos = card.global_position
		velocities.clear()

	if Input.is_action_just_released("click"):
		# if currently in swipe area, make sure it snaps to the locked spot
		if is_swiping:
			card.global_position = Vector2(1705, 461)

		# compute average if we have samples, otherwise report none
		if velocities.size() > 0 and cardd == true:
			var avg_vel: Vector2 = Vector2.ZERO
			for v in velocities:
				avg_vel += v
			avg_vel /= velocities.size()
			var speed = abs(avg_vel.x)
			if speed < 300:
				text_swiper.text = "Too slow, try again"
				acces_denied.play()
			elif speed > 350:
				text_swiper.text = "Too fast, try again"
				acces_denied.play()
			else:
				text_swiper.text = "Accepted, thank you"
				access_granted.play()
				await get_tree().create_timer(1.0).timeout
				emit_signal("card_swiped_granted")
				
			print("Average swipe velocity: ", avg_vel)

		# stop dragging and clear samples
		is_dragging = false
		velocities.clear()
		

	if is_dragging:
		if is_swiping:
			# horizontal-only movement while locked to y=461, with clamp limits
			var new_x: float = clamp(camera.get_global_mouse_position().x + drag_offset.x, 1655.0, 1965.0)
			card.global_position = Vector2(new_x, 461.0)
		else:
			card.global_position = camera.get_global_mouse_position() + drag_offset

		if _delta > 0.0:
			var frame_vel: Vector2 = (card.global_position - prev_pos) / _delta
			velocities.append(frame_vel)
			prev_pos = card.global_position

func _on_wallet_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not once and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		animation_player.play("wallet")
		once = true
		card.visible = true
		wallet.visible = true

func _on_card_mouse_entered() -> void:
	hover = true

func _on_card_mouse_exited() -> void:
	hover = false

func _on_swipe_area_entered(area: Area2D) -> void:
	is_swiping = true
	is_dragging = false
	cardd=true
	card.global_position = Vector2(1705, 461)
	
	drag_offset = Vector2.ZERO
	print("swipe entered")

func _on_swipe_area_exited(area: Area2D) -> void:
	is_swiping = false
	print("swipe exited")
