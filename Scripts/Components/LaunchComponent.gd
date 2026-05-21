extends Node
class_name LaunchComponent

@export var projectile : CharacterBody2D #Projectile
@export var LAUNCH_VECTOR : Vector2
@export var LAUNCH_SPEED : int
@export var LAUNCH_DISTANCE : int
@export var PULL_SPEED : int

var body : CharacterBody2D #Thrower
var pulling : bool = false
var launched : bool = false
var return_spot : Node2D
var movement_component : MovementComponent

func _process(delta: float) -> void:
	if launched:
		if Global.calculate_distance(return_spot.global_position, projectile) >= LAUNCH_DISTANCE:
			stop_launch()
	

func launch() -> void:
	Global.enable_top_level(projectile)
	movement_component.DISABLE_PHYSICS = true #Stops body's movement
	body.velocity = Vector2.ZERO
	projectile.velocity = LAUNCH_SPEED * LAUNCH_VECTOR
	launched = true
	
	
func stop_launch() -> void:
	projectile.velocity = Vector2.ZERO
	pull()
	
func pull() -> void:
	launched = false
	pulling = true
	body.velocity = PULL_SPEED * LAUNCH_VECTOR
	
func stop_pull() -> void:
	pulling = false
	movement_component.DISABLE_PHYSICS = false  #Re-enables body's movement
	if projectile is Hammer:
		projectile.return_to_player()
