extends CharacterBody2D
class_name Hammer

@export var DAMAGE : int
@export var COLLISION_BOX : Area2D
@export var LAUNCH_DIR : Vector2
@export var LAUNCH_SPEED : int
@export var THROW_DISTANCE : float
@export var input_component : InputComponent
@export var throw_component : ThrowComponent
@export var hammer_spot : Node2D

var is_on_cooldown : bool = false
var is_launching : bool = false
var initial_pos : Vector2 
var exited : bool = false #Latch for hammer entrance and exit
var tween : Tween




func _physics_process(delta: float) -> void:
	if throw_component.is_returning:
		return
	
	if input_component.is_throw_pressed:
		if input_component.throw_dir == Vector2(0,0): #if not direction pressed
			input_component.throw_dir = Vector2(1, 0) # throw right
		throw_component.throw_dir = input_component.throw_dir
		if not throw_component.is_thrown: #prevents throwing while thrown
			throw_component.throw()
	
	if throw_component.is_thrown:
		if get_slide_collision_count():#if there current collisions
			throw_component.check_collisions(get_slide_collision(0))
	
	input_component.is_throw_pressed = false
	
	if is_launching:
		if calculate_distance(initial_pos) >= THROW_DISTANCE:
			stop_launch()
			
	move_and_slide()

func swing() -> void:
	$AnimationPlayer.play("Swing")
	is_on_cooldown = true
	$cooldown.start()
	SignalManager.emit_signal("swing", COLLISION_BOX, DAMAGE)

func _on_cooldown_timeout() -> void:
	is_on_cooldown = false

func launch(delta : float) -> void:
	enable_top_level()
	is_launching = true
	velocity = LAUNCH_SPEED * LAUNCH_DIR
	
func stop_launch() -> void:
	velocity = Vector2.ZERO
	SignalManager.emit_signal("launch_finished", global_position)
	is_launching = false

func calculate_distance(initial_pos : Vector2) -> float:
	return (global_position - initial_pos).length()

func enable_top_level() -> void:
	initial_pos = global_position#saves current position
	top_level = true #makes position go whack | Makes node independent of parent node position wise
	global_position = initial_pos #puts it back in its position
	

func _on_hammer_return_body_entered(body: Node2D) -> void: #Resets hammer position
	if body == self and exited:
		return_hammer()
		
func return_hammer() -> void:
	position = hammer_spot.position
	exited = false
	SignalManager.emit_signal("stop_pulling")
	top_level = false
	throw_component.is_returning = false
	throw_component.is_thrown = false
	pass

func _on_hammer_return_body_exited(body: Node2D) -> void:
	exited = true
