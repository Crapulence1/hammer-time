extends Node
class_name MovementComponent

@export var body : CharacterBody2D
@export var SPEED : int = 300
@export var TOP_SPEED : int
@export var JUMP_FORCE : int = 100
@export var BASE_GRAVITY : int = 3
@export var AIR_MOVEMENT_SLOWDOWN_DELTA : float
@export var GROUND_FRICTION : float
@export var HAMMER_PULL_SPEED_MULTIPLIER : int
@export var AFFECTED_BY_GRAVITY : bool

var dir : int
var wants_jump : bool
var has_double_jump : bool = true
var wants_ground_boost : bool
var current_air_movement_damp : float
var is_pulling_to_hammer : bool = false
var current_gravity : float = BASE_GRAVITY
var turning_in_air : bool = false
var disable_physics : bool = false

func tick(delta : float) -> void:
	if body == null or disable_physics:
		return
	
	if body.is_on_floor():
		turning_in_air = false
		has_double_jump = true
		
		#TODO handle animation
		if wants_ground_boost:
			body.velocity.y = 2 * -JUMP_FORCE
		
		body.velocity.x = SPEED * dir
	
	if not body.is_on_floor():
		
		if (dir != sign(body.velocity.x) and dir != 0): #if holding opposite direction of movement while in air
			turning_in_air = true #turns on latch
		if turning_in_air:
			body.velocity.x = move_toward(body.velocity.x, dir * TOP_SPEED, AIR_MOVEMENT_SLOWDOWN_DELTA) #allows for mid air turning
		
		#Gravity
		body.velocity += body.get_gravity() * current_gravity * delta
		
	if wants_jump:
		if body.is_on_floor(): #normal jump
			body.velocity.y = -JUMP_FORCE
	
		if not body.is_on_floor() and has_double_jump: #double jumps
			body.velocity.y = -JUMP_FORCE
			has_double_jump = false;
	
	wants_jump = false
	wants_ground_boost = false

func pull_to_hammer(hammer_pos : Vector2) -> void:
	is_pulling_to_hammer = true #temporarily stops normal physics to pull to hammer
	var new_dir = (hammer_pos - body.global_position).normalized()
	body.velocity = new_dir * SPEED * HAMMER_PULL_SPEED_MULTIPLIER
