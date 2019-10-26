extends MotionState

func phy_process(delta:float) -> void:
	if get_input_direction():
		emit_signal("finished", next_state)