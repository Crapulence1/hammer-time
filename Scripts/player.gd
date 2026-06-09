extends CharacterBody2D
class_name Player



@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var hammer_component : HammerComponent

func _physics_process(delta: float) -> void:
	movement_component.wants_jump = input_component.is_jump_pressed
	input_component.is_jump_pressed = false
	
	movement_component.dir = input_component.dir
	
	if input_component.is_throw_pressed:
		input_component.is_throw_pressed = false
		hammer_component.throw()
	
	movement_component.tick(delta)
	move_and_slide()



func _on_hammer_catch_body_entered(body: Node2D) -> void:
	if body is Hammer:
		hammer_component.catch_hammer()
