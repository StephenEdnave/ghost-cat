extends Node2D

export(String) var initial_level : String
export(PackedScene) var camera_scene

onready var level_loader := $LevelLoader

var camera


func _ready() -> void:
	GameManager.game = self
	
	level_loader.load_level(initial_level, 0)
	camera = camera_scene.instance()
	level_loader.player.add_child(camera)