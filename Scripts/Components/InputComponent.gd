extends Node
class_name InputComponent

var dir : int
var is_jump_pressed : bool
var is_swing_pressed : bool
var is_hammer_bounce_pressed : bool
var is_launch_pressed : bool
var is_throw_pressed : bool
var is_slowfall_pressed : bool
var is_ground_pound_pressed : bool
var throw_dir : Vector2

func _process(delta: float) -> void:
	dir = Input.get_axis("Left", "Right")
	if Input.is_action_just_pressed("Jump"):
		is_jump_pressed = true
	
	if Input.is_action_just_pressed("Throw"):
		is_throw_pressed = true
	
