extends StaticBody2D

signal button_pressed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player or body is Hammer:
		emit_signal("button_pressed")
		print("button_pressed")
