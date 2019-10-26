extends KinematicBody2D
class_name Actor

signal died(actor)

onready var animation_player := $AnimationPlayer
onready var pivot := $Pivot

func _ready() -> void:
	assert animation_player
	animation_player.connect("animation_finished", $StateMachine, "_on_animation_finished")


func initialize() -> void:
	$StateMachine.initialize()


func die() -> void:
	emit_signal("died", self)