extends CharacterBody2D
class_name Player

@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var hammer_component : HammerComponent


var touching_ground : bool = false
func _physics_process(delta: float) -> void:
	movement_component.wants_jump = input_component.is_jump_pressed
	input_component.is_jump_pressed = false
	
	movement_component.dir = input_component.dir
	

	#Throw
	if input_component.is_throw_pressed:
		input_component.is_throw_pressed = false
		hammer_component.throw()
	
	#Launch
	if input_component.is_launch_pressed:
		input_component.is_launch_pressed = false
		hammer_component.launch()
	
	
	
	#Slow Fall
	if input_component.is_slowfall_pressed:
		input_component.is_slowfall_pressed = false
		if not touching_ground:
			hammer_component.slow_fall()
		
	if input_component.is_slowfall_released:
		input_component.is_slowfall_released = false
		hammer_component.reset_state()
		
	#Ground Pound
	if input_component.is_ground_pound_pressed:
		input_component.is_ground_pound_pressed = false
		if not touching_ground:
			hammer_component.ground_pound()
	
	if input_component.is_ground_pound_released:
		input_component.is_ground_pound_released = false
		hammer_component.reset_state()
	
	#Latch for touching ground
	if is_on_floor() and not touching_ground:
		touching_ground = true
	
	if not is_on_floor() and touching_ground:
		touching_ground = false
	
	movement_component.tick(delta)
	move_and_slide()

func _on_hammer_catch_body_entered(body: Node2D) -> void:
	if body is Hammer:
		movement_component.DISABLE_PHYSICS = false
		movement_component.DISABLE_INPUTS = false
		hammer_component.catch_hammer()
