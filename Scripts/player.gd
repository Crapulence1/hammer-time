extends CharacterBody2D

signal hammer_returned
signal touched_ground

@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var hammer : CharacterBody2D
@export var has_hammer_bounce : bool
@export var has_hammer_launch : bool
@export var floor_detect : Area2D

func _ready() -> void:
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
		movement_component.wants_hammer_bounce = input_component.is_hammer_bounce_pressed
		input_component.is_hammer_bounce_pressed = false
		has_hammer_bounce = false
	
	#Movement logic
	movement_component.dir = input_component.direction
	movement_component.tick(delta)
	
	#Hammer swing
	if input_component.is_swing_pressed and hammer and not hammer.is_on_cooldown:
		hammer.swing()
	
	move_and_slide()
	
func _on_hammer_return_body_entered(body: Node2D) -> void:
	if body is Hammer:
		emit_signal("hammer_returned")

func _on_hammer_pulling() -> void:
	movement_component.disable_physics = true

func _on_hammer_stopped_pulling() -> void:
	movement_component.disable_physics = false

func _on_floor_detect_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		emit_signal("touched_ground")
