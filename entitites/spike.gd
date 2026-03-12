extends Area2D

signal player_detected(type: int, at_pos: Vector2)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_detected.emit(body.type, body.global_position)
		$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1)
		$AudioStreamPlayer.play()
	elif body is Bird:
		player_detected.emit(3, body.global_position)
	
