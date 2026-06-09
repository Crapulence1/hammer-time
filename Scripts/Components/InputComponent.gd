extends Node
class_name InputComponent

var dir : int
var is_jump_pressed : bool
var is_swing_pressed : bool
var is_hammer_bounce_pressed : bool
var is_launch_pressed : bool
var is_throw_pressed : bool
var is_slowfall_pressed : bool
var is_slowfall_released : bool
var is_ground_pound_pressed : bool
var is_ground_pound_released : bool
var is_ground_pound_held : bool
var throw_dir : Vector2

func _process(delta: float) -> void:
	dir = Input.get_axis("Left", "Right")
	if Input.is_action_just_pressed("Jump"):
		is_jump_pressed = true
	
	if Input.is_action_just_pressed("Throw"):
		is_throw_pressed = true
	
	if Input.is_action_just_pressed("Hammer Launch"):
		is_launch_pressed = true
	
	if Input.is_action_pressed("Slowfall"):
		is_slowfall_pressed = true
	if Input.is_action_just_released("Slowfall"):
		is_slowfall_released = true
		
	if Input.is_action_just_pressed("Ground Pound"):
		is_ground_pound_pressed = true
	if Input.is_action_just_released("Ground Pound"):
		is_ground_pound_released = true
	is_ground_pound_held = Input.is_action_pressed("Ground Pound")
