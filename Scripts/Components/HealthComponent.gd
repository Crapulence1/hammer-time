extends Node
class_name HealthComponent

@export var health : int
@export var body : CharacterBody2D

func check_health() -> void:
	if health <= 0:
		body.queue_free()
		
