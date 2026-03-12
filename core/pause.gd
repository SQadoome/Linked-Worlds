extends Control

var paused: int = false
signal leave

func _input(event: InputEvent) -> void:
	if not paused:
		if event.is_action_pressed("pause"):
			show()
			paused = true
			get_tree().paused = true
	elif event is InputEventKey and paused:
		if event.is_pressed():
			if event.is_action_pressed("pause"):
				get_tree().paused = false
				leave.emit()
			else:
				hide()
				paused = false
				get_tree().paused = false
		
	
