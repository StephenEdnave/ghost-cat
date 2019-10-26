extends MotionState
class_name WalkState

export(String) var animation := "walk"

var IDLE_SPEED := 6.0


func enter() -> void:
	owner.animation_player.play(animation)


func phy_process(delta:float) -> void:
	move(get_input_direction())
	
	if velocity.length() < IDLE_SPEED:
		emit_signal("finished", "Idle")