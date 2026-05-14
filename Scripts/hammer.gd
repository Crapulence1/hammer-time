extends CharacterBody2D
class_name Hammer

enum STATE {Holding, Throwing, Launching}

signal pulling
signal stopped_pulling

@export var DAMAGE : int
@export var COLLISION_BOX : Area2D
@export var LAUNCH_DIR : Vector2
@export var LAUNCH_SPEED : int
@export var THROW_DISTANCE : float
@export var input_component : InputComponent
@export var throw_component : ThrowComponent
@export var launch_component : LaunchComponent
@export var hammer_spot : Node2D
@export var return_area : Area2D
@export var player : CharacterBody2D 

var is_on_cooldown : bool = false
var initial_pos : Vector2 
var exited : bool = false #Latch for hammer entrance and exit
var state

func _ready() -> void:
	launch_component.return_area = return_area
	launch_component.return_node = hammer_spot
	launch_component.launcher = player
	state = STATE.Holding

func _physics_process(delta: float) -> void:
	if throw_component.returning:
		return
	if state == STATE.Holding:
		if input_component.is_throw_pressed:
			
			if input_component.throw_dir == Vector2(0,0): #if not direction pressed
				input_component.throw_dir = Vector2(1, 0) # throw right
				
			throw_component.throw_dir = input_component.throw_dir
			
			if not throw_component.thrown: #prevents throwing while thrown
				throw_component.throw()
				state = STATE.Throwing
				
		if input_component.is_launch_pressed:
			launch_component.launch()
			state = STATE.Launching
		
		input_component.is_launch_pressed = false
		input_component.is_throw_pressed = false
	
	
	move_and_slide()

func swing() -> void:
	$AnimationPlayer.play("Swing")
	is_on_cooldown = true
	$cooldown.start()
	SignalManager.emit_signal("swing", COLLISION_BOX, DAMAGE)

func _on_cooldown_timeout() -> void:
	is_on_cooldown = false

func _on_hammer_return_body_exited(body: Node2D) -> void:
	exited = true

func _on_launch_component_pulling() -> void:
	emit_signal("pulling")

func _on_launch_component_stopped_pulling() -> void:
	emit_signal("stopped_pulling")

func _on_player_hammer_returned() -> void:
	if state == STATE.Throwing:
		throw_component.returning = false
		throw_component.thrown = false
		throw_component.throwable = true
		state = STATE.Holding
		top_level = false
		global_position = hammer_spot.global_position
		

	if state == STATE.Launching:
		launch_component.stop_pulling()
		state = STATE.Holding

func _on_player_touched_ground() -> void:
	launch_component.has_launch = true


func _on_collision_box_body_entered(body: Node2D) -> void:
	print(1)
	if body is Reflector and throw_component.relfectable:
		throw_component.reflect(body)
