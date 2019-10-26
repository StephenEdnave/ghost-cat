extends Area2D

var object : InteractableObject 


func interact() -> void:
	if object:
		object = null
		return
	
	var objects = get_overlapping_areas()
	for _object in objects:
		if _object is InteractableObject:
			object = _object
			break
	
	if not object:
		return
	
	object.interact()

func _physics_process(delta:float) -> void:
	if not object:
		return
	
	if object is PickableObject:
		object.global_position = global_position