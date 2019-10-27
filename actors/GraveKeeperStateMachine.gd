extends StateMachine

func _on_FieldOfView_area_entered(area):
	if area.owner is PlayerActor:
		change_state("NoticePlayer")

func _on_FieldOfView_area_exited(area):
	if area.owner is PlayerActor:
		change_state("Idle")
