extends MotionState


func enter() -> void:
	owner.pivot.modulate.a = 0.5
	owner.hurtbox.get_child(0).disabled = true


func exit() -> void:
	owner.pivot.modulate.a = 1
	owner.hurtbox.get_child(0).disabled = false


func phy_process(delta:float) -> void:
	if get_input_direction():
		emit_signal("finished", "Walk")