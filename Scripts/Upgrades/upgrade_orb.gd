extends Node2D

@export var anim : AnimationPlayer
@export var upgrade_name : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("rest")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	anim.play(anim_name)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var player = area.get_parent()
	if  player.name == "player":
		UpgradeManager.add_upgrade(upgrade_name)
	queue_free()
