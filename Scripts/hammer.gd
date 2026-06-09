extends CharacterBody2D
class_name Hammer



func _physics_process(delta: float) -> void: #just so the hammer can move
	
	move_and_slide()
