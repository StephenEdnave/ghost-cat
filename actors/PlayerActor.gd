extends Actor
class_name PlayerActor

onready var hurtbox = $Hurtbox

func _input(event):
	if event.is_action_pressed("interact"):
		$ObjectInteraction.interact()