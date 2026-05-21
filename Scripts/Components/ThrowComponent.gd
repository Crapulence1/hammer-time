extends Node
class_name ThrowComponent

signal projectile_thrown

@export var projectile : CharacterBody2D
@export var THROW_SPEED : int
@export var THROW_DISTANCE : int

var return_spot : Node2D
var thrown : bool = false
var returning : bool = false

func _process(delta: float) -> void:
	if thrown:
		if Global.calculate_distance(return_spot.global_position, projectile) >= THROW_DISTANCE:
			returning = true
	
	if returning:
		return_projectile(delta)
		
	if return_spot:
		if return_spot.global_position == projectile.global_position:
			returning = false
			thrown = false

func throw(throw_dir : int) -> void:
	thrown = true
	Global.enable_top_level(projectile)
	projectile.velocity.x = THROW_SPEED * throw_dir
	emit_signal("projectile_thrown")
	
func return_projectile(delta : float) -> void:
	projectile.velocity = Vector2.ZERO
	projectile.global_position = projectile.global_position.move_toward(return_spot.global_position, THROW_SPEED * delta)
	
	
