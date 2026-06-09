extends Node
class_name HammerComponent

#TODO after catching hammer pull for some reason only vertical momentum is conserved
#Horizontal momentum is 0

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
@export var LAUNCH_DIR : Vector2
@export var LAUNCH_DISTANCE : int
@export var PULL_SPEED : int

@export_group("Slow Fall Properties")
@export var SLOW_FALL_GRAVITY : float

@export_group("Ground Pound Properties")
@export var GROUND_POUND_SPEED : float

var default_dir : Vector2 = Vector2(1,0) #Default dir for throw and launch

func _process(delta: float) -> void:
	match state:
		Hammer_State.Throwing:
			if Global.calculate_distance(hammer_spot.global_position, hammer) >= THROW_DISTANCE:
				state = Hammer_State.Returning
				
		Hammer_State.Returning:
			return_throw(delta)
		
		Hammer_State.Launching:
			if Global.calculate_distance(hammer_spot.global_position, hammer) >= LAUNCH_DISTANCE:
				state = Hammer_State.Pulling
				player.movement_component.DISABLE_PHYSICS = true
				hammer.velocity = Vector2.ZERO
				
		Hammer_State.Pulling:
			pull()

#Throwing
##Throws hammer at indicated direction. If no direction is indicated the direction will default to whichever way the player is facing.
func throw(throw_direction : Vector2 = default_dir) -> void:
	if state != Hammer_State.Resting:
		return
	state = Hammer_State.Throwing
	Global.enable_top_level(hammer) #Independent movement
	hammer.velocity = throw_direction * THROW_SPEED
	
##Moves the hammer back to the hammer spot.
func return_throw(delta : float) -> void:
	hammer.velocity = Vector2.ZERO
	hammer.global_position = hammer.global_position.move_toward(hammer_spot.global_position, THROW_SPEED * delta) #Some code I copied somewhere and keep copying over

##Places hammer back in its rightful spot.
func catch_hammer() -> void:
	state = Hammer_State.Resting
	hammer.top_level = false
	hammer.velocity = Vector2.ZERO
	hammer.global_position =  hammer_spot.global_position

#Launching
##Launches the hammer at indicated direction.
func launch(launch_dir : Vector2 = LAUNCH_DIR) -> void:
	if state != Hammer_State.Resting:
		return
	player.movement_component.DISABLE_INPUTS = true
	state = Hammer_State.Launching
	Global.enable_top_level(hammer) #Independent Movement
	hammer.velocity = LAUNCH_SPEED * launch_dir #Speed, launch direction relative to player, absolute direction

##Pulls player from current position to hammer position.
func pull() -> void:
	#player.global_position = player.global_position.move_toward(hammer.global_position, PULL_SPEED * delta)
	player.velocity = (hammer.global_position - player.global_position).normalized() * PULL_SPEED

#Slow Fall
##Reduces the players gravity while falling.
func slow_fall() -> void:
	if state != Hammer_State.Resting:
		return
	if player.velocity.y > 0: #Only slow falls when falling
		player.movement_component.current_gravity = SLOW_FALL_GRAVITY
		state = Hammer_State.Slow_Falling

##Resets player gravity and hammer state.
func reset_state() -> void:
	state = Hammer_State.Resting
	player.movement_component.current_gravity = player.movement_component.GRAVITY
	player.movement_component.DISABLE_INPUTS = false
	
#Ground Pound
##Increases the players gravity heavily when not touching ground and prevents movements while ground pounding.
func ground_pound() -> void:
	if state != Hammer_State.Resting:
		return
	
	if player.velocity.y < 0: #if moving down don't stop velocity essentially
		player.velocity = Vector2.ZERO
	
	state = Hammer_State.Ground_Pounding
	player.velocity.y = GROUND_POUND_SPEED
	player.movement_component.DISABLE_INPUTS = true
