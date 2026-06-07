extends Node
class_name SlowfallComponent

@export var NEW_GRAVITY : int
var body : Player
var default_gravity : int

func _ready() -> void:
	await get_parent().hammer_loaded
	body.movement_component.connect("player_touched_ground", stop_slowfall)


func start_slowfall()-> void:
	if sign(body.velocity.y) == 1:
		body.movement_component.current_gravity = NEW_GRAVITY
		
func stop_slowfall() -> void:
	body.movement_component.current_gravity = body.movement_component.GRAVITY
	
