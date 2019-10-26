extends Node2D

export(PackedScene) var player_scene

var level : Level
var player

func load_level(level_name:String, player_spawn_number:=0) -> void:
	if level:
		level.queue_free()
	level = load(level_name).instance()
	add_child(level)
	
	player = player_scene.instance()
	level.spawn_player(player, player_spawn_number)
	
	level.initialize()