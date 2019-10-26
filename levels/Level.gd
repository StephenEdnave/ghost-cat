extends Node2D
class_name Level

onready var y_sort := $YSort


func initialize() -> void:
	for object in y_sort.get_children():
		if object is Actor:
			object.initialize()


func spawn_player(player, spawn_number:=0) -> void:
	var spawn_point = $PlayerSpawnPoints.get_child(spawn_number)
	y_sort.add_child(player)
	player.global_position = spawn_point.global_position