extends Node
class_name InputComponent

var direction : int
var is_jump_pressed : bool
var is_swing_pressed : bool
var is_ground_boost_pressed : bool
var is_launch_pressed : bool

func _process(delta: float) -> void:
	direction = Input.get_axis("Left", "Right")
	if Input.is_action_just_pressed("Jump"):
		is_jump_pressed = true
	is_swing_pressed = Input.is_action_pressed("Interact")
	if Input.is_action_just_pressed("Hammer Bounce") and UpgradeManager.has_upgrade("Hammer Bounce"):
		is_ground_boost_pressed = true
	if Input.is_action_just_pressed("Hammer Launch") and UpgradeManager.has_upgrade("Hammer Launch"):
		is_launch_pressed = true
