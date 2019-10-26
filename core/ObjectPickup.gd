extends Area2D

var object : PickableObject

func pickup() -> void:
	if object:
		object = null
	else:
		var objects = get_overlapping_areas()
		for _object in objects:
			if _object is PickableObject:
				object = _object
				return


func _physics_process(delta:float) -> void:
	if object:
		object.global_position = global_position