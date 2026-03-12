class_name Portal
extends Node2D

@onready var game_handler: GameHandler = get_tree().get_first_node_in_group("GameHandler")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		ascend_player(body)
		game_handler.player_ascended()
		$AuidoStreamPlayer.play()
	

func ascend_player(player: Player) -> void:
	var rotation_tween: Tween = create_tween().set_trans(Tween.TRANS_QUAD)
	var position_tween: Tween = create_tween().set_trans(Tween.TRANS_QUAD)
	var scale_tween: Tween = create_tween().set_trans(Tween.TRANS_QUAD)
	
	
	rotation_tween.finished.connect(rotation_tween.kill)
	position_tween.finished.connect(position_tween.kill)
	scale_tween.finished.connect(scale_tween.kill)
	
	if player.type == 1:
		# Pink
		
		var pink: Sprite2D = $Pink
		pink.visible = true
		
		pink.global_position = player.global_position
		player.queue_free()
		
		rotation_tween.tween_property(pink, "rotation_degrees", 360*2, 1.0)
		position_tween.tween_property(pink, "global_position", global_position, 1.0)
		scale_tween.tween_property(pink, "scale", Vector2(0, 0), 1.0)
		
	else:
		# Blue
		
		var blue: Sprite2D = $Blue
		blue.visible = true
		
		blue.global_position = player.global_position
		player.queue_free()
		
		rotation_tween.tween_property(blue, "rotation_degrees", 360*2, 1.0)
		position_tween.tween_property(blue, "global_position", global_position, 1.0)
		scale_tween.tween_property(blue, "scale", Vector2(0, 0), 1.0)
		
	
