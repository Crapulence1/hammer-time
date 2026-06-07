extends Node
class_name GroundPoundComponent


@export var DOWN_SPEED : int
var body : Player
var velocity_stopped : bool = false
var ground_pounding : bool = false

func start_ground_pound() -> void:
	
	if not ground_pounding:
		body.movement_component.DISABLE_INPUTS = true
		ground_pounding = true
		
		if not velocity_stopped:
			body.velocity = Vector2.ZERO
			velocity_stopped = true
			
		body.velocity = body.get_gravity() * DOWN_SPEED
	
func stop_ground_pound() -> void:
	pass
	#if ground_pounding:
		#ground_pounding = false
		#body.movement_component.DISABLE_INPUTS = false
		#body.movement_component.current_gravity = body.movement_component.GRAVITY
		#velocity_stopped = false
		
		#if not body.is_on_floor():
		#	body.velocity.y = body.movement_component.MAX_FALL_SPEED
