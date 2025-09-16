extends Node

var intro_music_time : float
var current_game = "intro"
var games = ["intro", "build-battle"]
var debug_mode = true
var dialogue_is_top = false
var PlayerScene = preload("res://Assets/Scenes/elevator_scene.tscn")
var build_battle_tutorial = false
var build_battle_robot_head_box_entered = false
var build_battle_robot_body_entered = false
var build_battle_continue_after_head = false
var screen_approaching_marker = false
var screen_approached = false
var build_battle_robot_can_move = true
