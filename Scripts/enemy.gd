extends CharacterBody2D

@export var target : CharacterBody2D
@export var movement_component : MovementComponent
@export var damage_component : DamageComponent

const SPEED = 100.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	movement_component.dir = sign(global_position.direction_to(target.global_position).x)
	movement_component.tick(delta)

	move_and_slide()
