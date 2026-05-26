extends CharacterBody2D
class_name Player

@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var hammer : Hammer
@export var anim : AnimationPlayer

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
	
	direction_checker()
	
	move_and_slide()
	
func direction_checker() -> void:
	if movement_component.dir == 1:
		anim.play("Right")
	if movement_component.dir == -1:
		anim.play("Left")
	pass
