extends KinematicBody2D
class_name Actor

onready var animation_player := $AnimationPlayer

func _ready() -> void:
	assert animation_player
	animation_player.connect("animation_finished", $StateMachine, "_on_animation_finished")


func initialize() -> void:
	$StateMachine.initialize()