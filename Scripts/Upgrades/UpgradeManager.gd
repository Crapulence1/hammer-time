extends Node

var current_upgrades : Array[Dictionary] = []


var available_upgrades : Array[Dictionary] = [
	{"Name": "Hammer Bounce", "Description": "Swing your hammer on the ground to gain a large vertical boost"},
	{"Name": "Hammer Launch", "Description": "Throw your hammer forward and up, then launch to it."}
	]
	
	
func find_upgrade(upgrade_name : String) -> Dictionary:
	var upgrade : Dictionary
	for i in available_upgrades:
		if i.find_key(upgrade_name):
			upgrade = i
	return upgrade
	

func has_upgrade(upgrade_name : String) -> bool:
	for i in current_upgrades:
		if i.find_key(upgrade_name) != null:
			return true
	return false

func add_upgrade(upgrade_name : String) -> void:
	current_upgrades.append(find_upgrade(upgrade_name))
