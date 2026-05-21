extends StaticBody2D

@export var BOUNCE_VECTOR : Vector2
@export var BOUNCE_SPEED : int

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "swing_hitbox":
		area.get_parent().emit_signal("bounced", BOUNCE_VECTOR, BOUNCE_SPEED)
		
