extends CharacterBody2D
class_name Hammer

@export var DAMAGE : int
@export var COLLISION_BOX : Area2D
@export var THROW_DIR : Vector2
@export var THROW_SPEED : int
@export var THROW_DISTANCE : float

var is_on_cooldown : bool = false
var is_throwing : bool = false
var initial_pos : Vector2 
var exited : bool = false #Latch for hammer entrance and exit

func _physics_process(delta: float) -> void:
	if is_throwing:
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
	initial_pos = global_position #saves current position
	top_level = true #makes position go whack | Makes node independent of parent node position wise
	global_position = initial_pos #puts it back in its position
	is_throwing = true
	velocity = THROW_SPEED * THROW_DIR
	
func stop_launch() -> void:
	velocity = Vector2.ZERO
	SignalManager.emit_signal("launch_finished", global_position)
	is_throwing = false

func calculate_distance(initial_pos : Vector2) -> float:
	return (global_position - initial_pos).length()


func _on_hammer_return_body_entered(body: Node2D) -> void: #Resets hammer position
	if body == self and exited:
		position = self.get_parent().get_node("hammer_spot").position
		exited = false
		SignalManager.emit_signal("stop_pulling")
		top_level = false
		


func _on_hammer_return_body_exited(body: Node2D) -> void:
	exited = true
