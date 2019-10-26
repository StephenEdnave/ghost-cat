extends Node
class_name State

signal finished(next_state)

export(String) var next_state := ""


func enter() -> void:
	pass


func exit() -> void:
	pass


func phy_process(delta:float) -> void:
	pass


func anim_finished(anim_name:String) -> void:
	pass