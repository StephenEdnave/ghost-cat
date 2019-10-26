extends MotionState


func enter() -> void:
	owner.pivot.modulate.a = 0.5


func exit() -> void:
	owner.pivot.modulate.a = 1


func phy_process(delta:float) -> void:
	if get_input_direction():
		emit_signal("finished", "Walk")