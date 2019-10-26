extends MotionState
class_name MoveToState

export(String) var animation : String = "walk"
export var roam_radius : float = 150.0
export(bool) var disable_obstacle_collider := false
export(float) var timeout_duration := 2.0
export(bool) var stagger := false

var target_position : Vector2 = Vector2()
var start_position : Vector2 = Vector2()
var TimeoutTimer := Timer.new()


func _ready() -> void:
	assert mass > 0
	_create_TimeoutTimer()


func _create_TimeoutTimer():
	TimeoutTimer = Timer.new()
	TimeoutTimer.wait_time = timeout_duration
	TimeoutTimer.one_shot = true
	TimeoutTimer.autostart = false
	add_child(TimeoutTimer)
	TimeoutTimer.connect("timeout", self, "_timeout")


func _timeout() -> void:
	emit_signal("finished", next_state)


func enter() -> void:
	start_position = owner.global_position
	
	TimeoutTimer.start()
	
	target_position = calculate_new_target_position()
	
	if owner.animation_player.has_animation(animation):
		owner.animation_player.play(animation)


func exit() -> void:
	TimeoutTimer.stop()
	owner.animation_player.play("SETUP")


func phy_process(delta : float) -> void:
	var buffer = 6.0
	if owner.global_position.distance_to(target_position) < buffer:
		owner.global_position = target_position
	else:
		move_to(target_position)
	
	.phy_process(delta)
	if owner.global_position.distance_to(target_position) < arrive_distance:
		emit_signal("finished", next_state)


func calculate_new_target_position() -> Vector2:
	randomize()
	var random_angle = randf() * 2 * PI
	randomize()
	var random_radius = (randf() * roam_radius) / 2 + roam_radius / 2
	return start_position + Vector2(cos(random_angle), sin(random_angle)) * random_radius


func take_damage(args := {}):
	if stagger:
		emit_signal("finished", "Stagger", args)