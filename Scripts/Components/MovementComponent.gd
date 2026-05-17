extends Node
class_name MovementComponent

@export var SPEED : int
@export var AIR_SPEED : int
@export var GROUND_FRICTION : float
@export var JUMP_FORCE : int
@export var GRAVITY : int
@export var DISABLE_PHYSICS : bool
@export var body : CharacterBody2D

var dir : int
var wants_jump : bool
var has_double_jump : bool = true

func tick(delta : float) -> void:
	if DISABLE_PHYSICS:
		return
	
	if body.is_on_floor():
		
		#Jump
		if wants_jump:
			body.velocity.y = -JUMP_FORCE
		
		#Ground Movement
		body.velocity.x = SPEED * dir
		
	if not body.is_on_floor():
		
		#Gravity
		body.velocity += body.get_gravity() * GRAVITY * delta
		
		#Air Control
		if dir != sign(body.velocity.x) and dir != 0:
			body.velocity.x = move_toward(body.velocity.x, dir * SPEED, AIR_SPEED)
		
		if wants_jump and has_double_jump:
			body.velocity.y = -JUMP_FORCE
	
