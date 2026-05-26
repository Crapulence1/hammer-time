extends Node
class_name SwingComponent


@export var anim : AnimationPlayer
@export var hammer : Hammer
@export var player : Player

func swing() -> void:
	SignalManager.emit_signal("swing", hammer.get_node("swing_hitbox"), player)
	anim.play("Swing")
	
	
	
