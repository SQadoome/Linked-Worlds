extends Node2D

var player_count: int = 0
signal pressed
signal released

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$Sprite2D.frame = 1
		player_count += 1
	

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_count -= 1
		
		if player_count <= 0:
			$Sprite2D.frame = 0
		
	
