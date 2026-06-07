extends CharacterBody2D
class_name Hammer

@export var throw_component : ThrowComponent
@export var launch_component : LaunchComponent
@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var swing_component : SwingComponent
@export var slowfall_component : SlowfallComponent 
@export var ground_pound_component : GroundPoundComponent
@export var hammer_return_spot : Node2D
@export var player : Player
@export var anim : AnimationPlayer

signal bounced
signal hammer_loaded
var throw_dir : int


func _ready() -> void:
	Global.hammer = self
	launch_component.body = player
	slowfall_component.body = player
	ground_pound_component.body = player
	connect("bounced", bounce)
	emit_signal("hammer_loaded")

func _physics_process(delta: float) -> void:
	
	#Setting component variables
	launch_component.return_spot = hammer_return_spot
	launch_component.movement_component = movement_component
	throw_component.return_spot = hammer_return_spot
	
	#Throw
	if input_component.is_throw_pressed and not throw_component.thrown:
		set_collision_mask_value(1, true)
		input_component.is_throw_pressed = false
		throw_component.throw(throw_dir)
	
	#Launch
	if input_component.is_launch_pressed and not launch_component.launched:
		set_collision_mask_value(1, true)
		input_component.is_launch_pressed = false
		launch_component.launch()
	
	#Swing
	swing_component.player = player
	if input_component.is_swing_pressed and not anim.is_playing():
		swing_component.swing()
		
	#Slowfall
	if input_component.is_slowfall_pressed:
		slowfall_component.start_slowfall()
	else:
		slowfall_component.stop_slowfall()
		
	#Ground Pound
	if input_component.is_ground_pound_pressed:
		ground_pound_component.start_ground_pound()
	else:
		ground_pound_component.stop_ground_pound()
		
	
	#Hammer collides with wall
	if is_on_wall():
		
		if launch_component.launched:
			launch_component.stop_launch()
			
		if throw_component.thrown:
			throw_component.return_projectile(delta)
			throw_component.returning = true
			
		#Disables hammer collision w/ ground
		set_collision_mask_value(1, false)
	
	move_and_slide()

func _on_hammer_return_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Hammer:
		if launch_component.pulling:
			launch_component.stop_pull()
		return_to_player()

#Returns hammer to specified spot
func return_to_player() -> void:
	velocity = Vector2.ZERO
	top_level = false
	global_position = hammer_return_spot.global_position
	set_collision_mask_value(1, false)
	
func bounce(BOUNCE_VECTOR : Vector2, BOUNCE_SPEED : int) -> void:
	player.velocity = BOUNCE_VECTOR * BOUNCE_SPEED
