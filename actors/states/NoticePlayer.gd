extends MotionState

export(String) var animation := "notice"
export(float) var timeout_duration := 2.0

var TimeoutTimer := Timer.new()
var target

var run_to_player := false


func _ready() -> void:
	_create_TimeoutTimer()


func enter() -> void:
	run_to_player = false
	target = get_tree().get_nodes_in_group("players")[0]
	
	owner.animation_player.play(animation)


func anim_finished(anim_name:String) -> void:
	run_to_player = true
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
	if run_to_player:
		move_to(target.global_position)