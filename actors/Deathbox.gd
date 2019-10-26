extends Area2D



func _on_Deathbox_area_entered(area):
	if area.owner is PlayerActor:
		area.owner.die()