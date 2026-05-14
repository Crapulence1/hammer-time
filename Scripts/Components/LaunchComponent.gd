extends Node
class_name LaunchComponent

signal pulling
signal stopped_pulling
signal give_launch

@export var LAUNCH_DIR : Vector2
@export var LAUNCH_SPEED : int
@export var LAUNCH_DISTANCE : int
@export var PULL_SPEED : int
@export var body : Hammer

var launcher : CharacterBody2D
var return_node : Node2D #initial position holder for hammer
var return_area : Area2D #area where hammer needs to meet to return to spot
var is_launching : bool = false
var has_launch : bool = true

func _ready() -> void:
	if return_area:
		return_area.connect("hammer_returned", stop_pulling)

func _process(delta: float) -> void:
	if is_launching:
		if LAUNCH_DISTANCE <= Global.calculate_distance(return_node.global_position, body):
			stop_launch()

func launch() -> void:
	if has_launch:
		Global.enable_top_level(body) #allows for hammer to move indpendently of launcher
		body.velocity = LAUNCH_DIR * LAUNCH_SPEED
		is_launching = true
		has_launch = false
		
	
func stop_launch() -> void:
	is_launching = false
	body.velocity = Vector2.ZERO
	start_pull()

func start_pull() -> void:
	emit_signal("pulling")
	launcher.velocity = LAUNCH_DIR * PULL_SPEED
	
	
func stop_pulling() -> void:
	body.top_level = false #re-enables dependent movement
	body.global_position = return_node.global_position
	emit_signal("stopped_pulling")
