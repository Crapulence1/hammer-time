extends CharacterBody2D

@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var hammer : CharacterBody2D
@export var has_hammer_bounce : bool
@export var has_hammer_launch : bool

func _ready() -> void:
	SignalManager.connect("launch_finished", handle_finished_launch)
	SignalManager.connect("stop_pulling", handle_stopped_pull)
	
	#Dev Tools
	if has_hammer_bounce:
		UpgradeManager.add_upgrade("Hammer Bounce")
	if has_hammer_launch:
		UpgradeManager.add_upgrade("Hammer Launch")

func _physics_process(delta: float) -> void:
	#latch bc physics_process and normal process are out of sync
	movement_component.wants_jump = input_component.is_jump_pressed
	input_component.is_jump_pressed = false
	
	#Hammer Bounce
	if UpgradeManager.has_upgrade("Hammer Bounce"):
		movement_component.wants_ground_boost = input_component.is_ground_boost_pressed
		input_component.is_ground_boost_pressed = false
	
	#Hammer Launch
	if input_component.is_launch_pressed and UpgradeManager.has_upgrade("Hammer Launch"):
		hammer.launch(delta)
		input_component.is_launch_pressed = false
	
	#Movement logic
	movement_component.dir = input_component.direction
	movement_component.tick(delta)
	
	#Hammer swing
	if input_component.is_swing_pressed and hammer and not hammer.is_on_cooldown:
		hammer.swing()
	
	move_and_slide()
	
func handle_finished_launch(hammer_pos) -> void: #Begins pulling to hammer
	movement_component.pull_to_hammer(hammer_pos)
	
func handle_stopped_pull() -> void: #Re-enables normal physics
	movement_component.is_pulling_to_hammer = false
