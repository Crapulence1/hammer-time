extends Node
class_name MovementComponent

@export var TOP_SPEED : int
@export var ACCELERATION : int
@export var AIR_SPEED : int
@export var GROUND_FRICTION : float
@export var JUMP_FORCE : int
@export var GRAVITY : int
@export var DISABLE_PHYSICS : bool
@export var body : CharacterBody2D

var dir : int
var wants_jump : bool
var has_double_jump : bool = true
var turning_in_air : bool = false

var current_air_speed : int


func _ready() -> void:
	SignalManager.connect("bounced",set_air_speed)

func tick(delta : float) -> void:
	if DISABLE_PHYSICS:
		return
	
	if body.is_on_floor():
		
		#Jump
		if wants_jump:
			body.velocity.y = -JUMP_FORCE
		
		#Ground Movement
		body.velocity.x = move_toward(body.velocity.x, TOP_SPEED * dir, ACCELERATION)
		
		#Sets Air Speed
		current_air_speed = AIR_SPEED
		
		turning_in_air = false
		
	if not body.is_on_floor():
		
		#Gravity
		body.velocity += body.get_gravity() * GRAVITY * delta
		
		#Air Control
		if (dir != sign(body.velocity.x) and dir != 0): #if holding opposite direction of movement while in air
			turning_in_air = true #turns on latch
			
		if turning_in_air:
			body.velocity.x = move_toward(body.velocity.x, dir * TOP_SPEED, current_air_speed) #allows for mid air turning
		
		if (dir == 0):
			turning_in_air = false
		
		#Double Jump
		if wants_jump and has_double_jump:
			body.velocity.y = -JUMP_FORCE
	

func set_air_speed(new_air_speed : int) -> void:
	current_air_speed = new_air_speed
