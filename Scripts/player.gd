extends CharacterBody2D

@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var hammer : Hammer

var facing_dir : int = 1

func _physics_process(delta: float) -> void:
	#Movement Direction
	movement_component.dir = input_component.direction
	
	#Jump
	movement_component.wants_jump = input_component.is_jump_pressed
	input_component.is_jump_pressed = false
	
	#Movement ticks
	movement_component.tick(delta)
	
	#Facing Direction
	if input_component.direction != 0:
		facing_dir = input_component.direction
	
	hammer.throw_dir = facing_dir
	
	move_and_slide()
