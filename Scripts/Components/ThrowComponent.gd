extends Node
class_name ThrowComponent

@export var body : Hammer
@export var THROW_SPEED : int
@export var THROW_DISTANCE_CUTOFF : int
@export var RETURN_SPEED : int
@export var relfectable : bool

var throw_dir : Vector2
var thrown : bool
var throwable : bool = true
var returning : bool = false
var dead : bool = false
var alive : bool = true

func _process(delta: float) -> void:
	if dead:
		kill()
	if thrown:
		if Global.calculate_distance(body.initial_pos, body) >= THROW_DISTANCE_CUTOFF:
			stop_throw()
			
	if returning:
		body.global_position = body.global_position.move_toward(body.hammer_spot.global_position, RETURN_SPEED * delta)

func kill():
	alive = false

func throw() -> void:
	thrown = true
	Global.enable_top_level(body)
	body.initial_pos = body.global_position
	body.velocity = THROW_SPEED * throw_dir
	
func stop_throw() -> void:
	body.velocity = Vector2.ZERO
	returning = true
	
func reflect(reflector : Reflector) -> void:
	var raycast : RayCast2D = reflector.raycast
	body.global_position = reflector.global_position
	var reflect_dir : Vector2 = (raycast.to_global(raycast.target_position) - raycast.to_global(Vector2.ZERO)).normalized() #raycast global direction code i copiedd
	throwable = false
	body.velocity = reflect_dir * THROW_SPEED
	print(1)
	
