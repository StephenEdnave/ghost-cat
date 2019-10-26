extends Node
class_name StateMachine

var current_state

func _ready() -> void:
	for state in get_children():
		assert state is State
		state.connect("finished", self, "change_state")
	
	initialize()


func initialize() -> void:
	current_state = get_child(0)
	current_state.enter()


func change_state(next_state_name:String) -> void:
	current_state.exit()
	if next_state_name:
		current_state = get_node(next_state_name)
		current_state.enter()


func _physics_process(delta:float) -> void:
	current_state.phy_process(delta)


func _on_animation_finished(anim_name):
	current_state.anim_finished(anim_name)