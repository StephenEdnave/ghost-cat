extends MotionState
class_name WalkState

var IDLE_SPEED := 6.0

func phy_process(delta:float) -> void:
	move(get_input_direction())
	
	if velocity.length() < IDLE_SPEED:
		emit_signal("finished", "Idle")