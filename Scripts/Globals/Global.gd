extends Node


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		get_tree().quit()

##Allows for child node to move independently of parent node.
func enable_top_level(body : Node2D) -> void: 
	var initial_pos : Vector2
	initial_pos = body.global_position#saves current position
	body.top_level = true #makes position go whack | Makes node independent of parent node position wise
	body.global_position = initial_pos #puts it back in its position

##Returns the length between a position and a node
func calculate_distance(initial_pos : Vector2, body : Node2D) -> float: #calculates distance nincompoop
	return (body.global_position - initial_pos).length()
