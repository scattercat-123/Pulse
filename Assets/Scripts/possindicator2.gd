extends Node2D

@onready var indicator =$indicator

func _process(_delta):
	var canvas = get_canvas_transform() 
	var top_left = -canvas.origin/canvas.get_scale()
	var size = get_viewport_rect().size /canvas.get_scale()
	
	set_pos(Rect2(top_left,size))
	set_the_rotation()
	indicator.visible = Global.build_battle_robot_head_box_entered and not Global.build_battle_robot_body_entered

func set_pos(bounds:Rect2):
	indicator.global_position.x = clamp(global_position.x,bounds.position.x,bounds.end.x)
	indicator.global_position.y = clamp(global_position.y,bounds.position.y,bounds.end.y)
	

func set_the_rotation():
	var angle = (global_position-indicator.global_position).angle()
	indicator.global_rotation = angle
	
