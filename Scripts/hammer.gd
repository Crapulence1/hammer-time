extends CharacterBody2D
class_name Hammer

@export var throw_component : ThrowComponent
@export var input_component : InputComponent
@export var hammer_return_spot : Node2D

var throw_dir : int
var returning : bool = false
func _physics_process(delta: float) -> void:
	
	if returning:
		throw_component.return_projectile(delta)
		return
	
	throw_component.return_spot = hammer_return_spot
	
	if Global.calculate_distance(hammer_return_spot.global_position, self) >= throw_component.THROW_DISTANCE:
		returning = true
	
	#Throw
	if input_component.is_throw_pressed:
		input_component.is_throw_pressed = false
		throw_component.throw(throw_dir)
	
	move_and_slide()


func _on_hammer_return_area_area_entered(area: Area2D) -> void:
	return_to_player()

func return_to_player() -> void:
	velocity = Vector2.ZERO
	top_level = false
	global_position = hammer_return_spot.global_position
	returning = false
