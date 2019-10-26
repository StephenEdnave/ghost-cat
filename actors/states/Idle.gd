extends MotionState

export(String) var animation := "idle"
export(float) var timeout_duration := 2.0

var TimeoutTimer := Timer.new()


func _ready() -> void:
	_create_TimeoutTimer()


func enter() -> void:
	owner.animation_player.play(animation)
	TimeoutTimer.start()


func _create_TimeoutTimer():
	TimeoutTimer = Timer.new()
	TimeoutTimer.wait_time = timeout_duration
	TimeoutTimer.one_shot = true
	TimeoutTimer.autostart = false
	add_child(TimeoutTimer)
	TimeoutTimer.connect("timeout", self, "_timeout")


func _timeout() -> void:
	emit_signal("finished", next_state)


func phy_process(delta:float) -> void:
	if get_input_direction():
		emit_signal("finished", next_state)