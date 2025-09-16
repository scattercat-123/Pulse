extends CharacterBody2D
@export var SPEED = 300.0
var direction = 0
@onready var player: CharacterBody2D = $"."
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if player.direction == 1:
		player_sprite.flip_h = false
	elif player.direction == -1:
		player_sprite.flip_h = true
		
	if abs(player.velocity.x) > 0:
		pass
	else:
		player_sprite.play("idle")
