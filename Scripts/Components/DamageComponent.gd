extends Node
class_name DamageComponent


@export var hitbox : Area2D
@export var health_component : HealthComponent

func _ready() -> void:
	SignalManager.connect("swing", handle_collision)
	
	
func handle_collision(collision_box : Area2D, damage : int) -> void:
	if collision_box.get_parent() is Hammer:
		handle_hit(damage)


func handle_hit(damage : int) -> void:
	health_component.health -= damage
	health_component.check_health()
	print("Hit!")
	pass
