extends InteractableObject
class_name HauntableObjectTV

onready var animator = $AnimationPlayer
var haunted = false;

func interact() -> void:
	haunted = !haunted;
	changeAnim();
	
func changeAnim() -> void:	
	if haunted:
		animator.play("haunted")
	else:
		animator.play("normal")