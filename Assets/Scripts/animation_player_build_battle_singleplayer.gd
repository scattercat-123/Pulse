extends AnimatedSprite2D

@onready var player: Orange = get_parent()
@onready var animation_player: AnimatedSprite2D = $"."
@onready var player_sprite: AnimatedSprite2D = $"."

var died = false
var pressed_jump = false
var was_falling = false

func _process(_delta: float) -> void:
	# Flip sprite
	if player.direction == 1:
		player_sprite.flip_h = false
	elif player.direction == -1:
		player_sprite.flip_h = true

	# 1. Death
	if player.position.y > 800 and not died:
		animation_player.play("died")
		died = true
		dying()	
		return

	# 2. Jump (trigger once when pressed on floor)
	if Input.is_action_just_pressed("jump") and animation_player.animation != "jump" and player.player_in_stairs == false:
		animation_player.play("jump")
		return
			
	# run
	if abs(player.velocity.x) > 0 and player.is_on_floor() and player.player_in_stairs == false:
		animation_player.play("run")
		return
		
	if player.velocity.x == 0  and player.player_in_stairs == false and was_falling == false and animation_player.animation != "land":
		animation_player.play("idle")
		
	if animation_player.animation != "jump" and player.is_on_floor() == false and player.player_in_stairs == false and was_falling == false and animation_player.animation != "land":
		animation_player.play("fall")
		
	if player.player_in_stairs:
		var dir_y = Input.get_axis("move_up", "move_down")
		if dir_y != 0:
			animation_player.play("stairs")
		elif abs(player.velocity.x) < 1:
			animation_player.play("stairs_idle")
		return
			
	if not player.is_on_floor() and player.velocity.y > 0:
		was_falling = true
	elif player.is_on_floor() and was_falling:
		animation_player.play("land")
		was_falling = false
		return


func dying():
	died = false
	player.position = Vector2(1165, 530)
	
