extends Node2D

@export var animation_tree : AnimationTree
@export var player : CharacterBody2D

var face_direction : int = 1
func _physics_process(delta: float) -> void:
	if player.velocity.x != 0:
		face_direction = sign(player.velocity.x)
	animation_tree.set("parameters/conditions/Idle", player.velocity.x == 0)
	animation_tree.set("parameters/conditions/Walk", player.velocity.x != 0)
	
	animation_tree.set("parameters/Idle/blend_position", Vector2(face_direction, 0))
	animation_tree.set("parameters/Walk/blend_position", player.velocity)
