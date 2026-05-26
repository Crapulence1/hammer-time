extends StaticBody2D


@export var RAYCAST : RayCast2D
@export var BOUNCE_SPEED : int
@export var new_air_speed : int

@export var hitbox : Area2D

func _ready() -> void:
	SignalManager.connect("swing", check_swing)
	
	#Pasta?
func check_swing(hammer_hitbox : Area2D, player : Player) -> void:
	
	if hammer_hitbox.overlaps_area(hitbox):
		player.velocity = (RAYCAST.to_global(RAYCAST.target_position) - RAYCAST.to_global(Vector2.ZERO)).normalized() * BOUNCE_SPEED
		player.movement_component.set_air_speed(new_air_speed)
		player.movement_component.turning_in_air = false
		
		if player.facing_dir == 1:
			player.anim.play("Left")
			player.facing_dir= -1
		elif player.facing_dir == -1:
			player.anim.play("Right")
			player.facing_dir = 1
			
	
