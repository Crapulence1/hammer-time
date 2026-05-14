extends Node
class_name ThrowComponent

@export var body : Hammer
@export var THROW_SPEED : int
@export var THROW_DISTANCE_CUTOFF : int
@export var RETURN_SPEED : int

var throw_dir : Vector2
var wants_throw : bool
var is_thrown : bool
var is_returning : bool = false


func _process(delta: float) -> void:
	if is_thrown:
		if body.calculate_distance(body.initial_pos) >= THROW_DISTANCE_CUTOFF:
			stop_throw()
	if is_returning:
		body.global_position = body.global_position.move_toward(body.hammer_spot.global_position, RETURN_SPEED * delta)

func throw() -> void:
	is_thrown = true
	body.enable_top_level()
	body.initial_pos = body.global_position
	body.velocity = THROW_SPEED * throw_dir
	
func stop_throw() -> void:
	body.velocity = Vector2.ZERO
	is_returning = true
	
func check_collisions(last_slide_collision : KinematicCollision2D) -> void:
	var current_collider = last_slide_collision.get_collider()
	if current_collider is Reflector:
		var raycast : RayCast2D = current_collider.raycast
		body.global_position = raycast.global_position #+ Vector2(0, -1)
		body.velocity = (raycast.to_global(raycast.target_position) - raycast.to_global(Vector2.ZERO)).normalized() * THROW_SPEED #raycast global direction code i copiedd
		body.initial_pos = body.global_position
		print(body.global_position)
		
	else:
		body.return_hammer()
		
	#if not past_collider or past_collider != current_collider:
		#past_collider = current_collider
