extends Node
class_name AnimationComponent


@export var property : String #What attribute i want the animation to be based on
@export var body : Node2D
@export var animation_tree : AnimationTree

func _physics_process(delta: float) -> void:
	var value = body.get(property)
	if value is Vector2:
		animation_tree.set("parameters/blend_position", value.normalized())
	
