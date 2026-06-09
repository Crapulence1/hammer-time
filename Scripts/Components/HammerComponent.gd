extends Node
class_name HammerComponent

##Hammers current state.
enum Hammer_State {Resting, Throwing, Returning, Launching, Pulling, Ground_Pounding, Slow_Falling}
var state : Hammer_State = Hammer_State.Resting

@export var player : Player
@export var movement_component : MovementComponent
@export var hammer : CharacterBody2D
@export var hammer_spot : Marker2D

@export_group(("Throw Properties"))
@export var THROW_SPEED : int
@export var THROW_DISTANCE : int

@export_group("Launch Properties")
@export var LAUNCH_SPEED : int
@export var PULL_SPEED : int

@export_group("Slow Fall Properties")
@export var SLOW_FALL_GRAVITY : float

@export_group("Ground Pound Properties")
@export var GROUND_POUND_GRAVITY : float

var default_throw_dir : Vector2 = Vector2(1,0) #Default throw_dir

func _process(delta: float) -> void:
	
	match state:
		Hammer_State.Throwing:
			if Global.calculate_distance(hammer_spot.global_position, hammer) >= THROW_DISTANCE:
				state = Hammer_State.Returning
				
		Hammer_State.Returning:
			return_throw(delta)

##Throws hammer at indicated direction. If no direction is indicated the direction will default to whichever way the player is facing.
func throw(throw_direction : Vector2 = default_throw_dir) -> void:
	state = Hammer_State.Throwing
	Global.enable_top_level(hammer) #Independent movement
	hammer.velocity = throw_direction * THROW_SPEED
	print(hammer.velocity)
	
##Moves the hammer back to the hammer spot.
func return_throw(delta : float) -> void:
	hammer.velocity = Vector2.ZERO
	hammer.global_position = hammer.global_position.move_toward(hammer_spot.global_position, THROW_SPEED * delta) #Some code I copied somewhere and keep copying over

##Places hammer back in its rightful spot.
func catch_hammer() -> void:
	hammer.top_level = false
	hammer.velocity = Vector2.ZERO
	hammer.global_position =  hammer_spot.global_position
	state = Hammer_State.Resting
