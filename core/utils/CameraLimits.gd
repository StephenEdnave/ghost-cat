extends Area2D
class_name CameraLimits

export(Vector2) var zoom := Vector2(1, 1)
export(float) var zoom_tween_value := 0.1
export(float) var limits_tween_value := 0.1

onready var limits := $Limits
onready var trigger := $CollisionTrigger

func change(area) -> void:
	var camera_limits = {
		"left" : limits.global_position.x - limits.shape.extents.x,
		"right" : limits.global_position.x + limits.shape.extents.x,
		"bottom" : limits.global_position.y + limits.shape.extents.y,
		"top" : limits.global_position.y - limits.shape.extents.y
	}
	
	GameManager.game.camera.change_limits(camera_limits, limits_tween_value)
	
	GameManager.game.camera.change_target_zoom(zoom, zoom_tween_value)
	print("DEBUG AAAA")