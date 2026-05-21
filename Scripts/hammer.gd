extends CharacterBody2D
class_name Hammer

@export var throw_component : ThrowComponent
@export var launch_component : LaunchComponent
@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var swing_component : SwingComponent
@export var hammer_return_spot : Node2D
@export var body : CharacterBody2D
@export var anim : AnimationPlayer

signal bounced

var throw_dir : int

func _ready() -> void:
	launch_component.body = body
	connect("bounced", bounce)

func _physics_process(delta: float) -> void:
	
	#Setting component variables
	launch_component.return_spot = hammer_return_spot
	launch_component.movement_component = movement_component
	throw_component.return_spot = hammer_return_spot
	
	#Throw
	if input_component.is_throw_pressed and not throw_component.thrown:
		input_component.is_throw_pressed = false
		throw_component.throw(throw_dir)
	
	#Launch
	if input_component.is_launch_pressed and not launch_component.launched:
		input_component.is_launch_pressed = false
		launch_component.launch()
	
	#Swing
	if input_component.is_swing_pressed and not anim.is_playing():
		swing_component.swing()
	
	move_and_slide()


func _on_hammer_return_area_area_entered(area: Area2D) -> void:
	if launch_component.pulling:
		launch_component.stop_pull()
	return_to_player()

func return_to_player() -> void:
	velocity = Vector2.ZERO
	top_level = false
	global_position = hammer_return_spot.global_position
	
func bounce(BOUNCE_VECTOR : Vector2, BOUNCE_SPEED : int) -> void:
	body.velocity = BOUNCE_VECTOR * BOUNCE_SPEED
