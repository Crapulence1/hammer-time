extends Node
#Global functions

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Escape"):
		get_tree().quit()

func enable_top_level(body : Node2D) -> void:
	var initial_pos : Vector2
	initial_pos = body.global_position#saves current position
	body.top_level = true #makes position go whack | Makes node independent of parent node position wise
	body.global_position = initial_pos #puts it back in its position

func calculate_distance(initial_pos : Vector2, body : Node2D) -> float:
	return (body.global_position - initial_pos).length()
