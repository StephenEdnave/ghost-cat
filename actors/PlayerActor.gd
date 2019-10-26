extends Actor
class_name PlayerActor

func _input(event):
	if event.is_action_pressed("pickup"):
		$ObjectPickup.pickup()