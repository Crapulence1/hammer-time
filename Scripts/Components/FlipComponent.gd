extends Node
class_name FlipComponent

@export var flipper : Node2D
@export var entity : CharacterBody2D
@export var sprite : Sprite2D
var dir : int
var facing_dir : int

func handle_flip() -> void:
	if dir != 0:
		facing_dir = dir
	#if dir == 1:
		#entity.scale.x = abs(entity.scale.x)
	#elif dir == -1:
		#entity.scale.x = -abs(entity.scale.x)
		
	if dir == 1: #moving right
		sprite.flip_h = false
		for i in flipper.get_children():
			i.position.x = abs(i.position.x) * 1
	elif dir == -1:
		sprite.flip_h = true
		for i in flipper.get_children():
			i.position.x = abs(i.position.x) * -1
