extends State
class_name MotionState

const VECTOR_UP = Vector2(0, -1)


export(bool) var mirror_x := true
export(float) var max_speed := 460.0
export(float) var mass := 4.0
export(float) var arrive_distance := 6.0
export(float) var slow_radius := 200.0
export(float) var gravity := 2400.0
export(float) var max_gravity_speed := 1400.0

export(bool) var look_towards_move_direction := true

var velocity : Vector2
var gravity_speed : float

var external_motion : Dictionary = {
	"velocity" : Vector2(),
	"direction" : Vector2(0, -1),
	"target_speed" : 0.0,
	"mass" : 1.0
}


func _ready() -> void:
	call_deferred("assert", owner is KinematicBody2D)


func enter(args := {}) -> void:
	if args.has("velocity"):
		velocity = args["velocity"]
	if args.has("gravity_speed"):
		gravity_speed = args["gravity_speed"]


func exit() -> void:
	reset()


func phy_process(delta : float) -> void:
	if look_towards_move_direction:
		update_look_direction(velocity.normalized())
	move_external_motion()
	apply_gravity(delta)


func reset() -> void:
	velocity = Vector2()
	gravity_speed = 0


func get_input_direction() -> Vector2:
	var input_direction : Vector2 = Vector2()
	if owner.is_in_group("players"):
		input_direction.x = Input.is_action_pressed("ui_right") as int - Input.is_action_pressed("ui_left") as int
		input_direction.y = Input.is_action_pressed("ui_down") as int - Input.is_action_pressed("ui_up") as int
	return input_direction


func move(move_direction : Vector2) -> void:
	var target_position : Vector2 = owner.global_position + move_direction.normalized() * max_speed
	velocity = Steering.follow(velocity, owner.global_position, target_position, max_speed * owner.global_scale.length(), mass)
	owner.move_and_slide(velocity, VECTOR_UP)
	update_last_move_direction(velocity.normalized())


func move_to(target_position : Vector2) -> void:
	velocity = Steering.arrive_to(velocity, owner.global_position, target_position, max_speed, mass, slow_radius)
	if owner.global_position.distance_to(target_position) < arrive_distance:
		owner.global_position = target_position
		return
	owner.move_and_slide(velocity, VECTOR_UP)
	update_last_move_direction(velocity.normalized())


func apply_gravity(delta : float) -> void:
	gravity_speed = min(gravity_speed + gravity * delta, max_gravity_speed)
	owner.move_and_slide(Vector2(0, gravity_speed), VECTOR_UP)
	if owner.is_on_floor():
		gravity_speed = 0
		velocity.y = 0


func apply_external_motion(velocity:Vector2, direction:Vector2, target_speed:float, mass:float) -> void:
	external_motion["velocity"] = velocity
	external_motion["direction"] = direction
	external_motion["target_speed"] = target_speed
	external_motion["mass"] = mass


func move_external_motion() -> void:
	var target_position : Vector2 = owner.global_position + external_motion["direction"].normalized() * external_motion["target_speed"]
	external_motion["velocity"] = Steering.follow(external_motion["velocity"], owner.global_position, target_position, external_motion["target_speed"] * owner.global_scale.length(), external_motion["mass"])
	owner.move_and_slide(velocity, VECTOR_UP)


func update_last_move_direction(direction : Vector2) -> void:
	if "last_move_direction" in owner:
		owner.last_move_direction = direction


func update_look_direction(direction : Vector2) -> void:
	if not mirror_x:
		return
	var velocity_threshold = 6.0
	if velocity.x >= -velocity_threshold and velocity.x <= velocity_threshold:
		return
	if direction.x < 0:
		owner.pivot.scale.x = abs(owner.pivot.scale.x) * -1
		return
	owner.pivot.scale.x = abs(owner.pivot.scale.x)