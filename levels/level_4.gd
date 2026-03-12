class_name Level
extends Node2D

@export var LOCKED: StaticBody2D

func _on_spike_player_detected(type: int, at_pos: Vector2) -> void:
	if type == 3:
		if $Player1Stuff/PinkPlayer.bird != null:
			$Player1Stuff/PinkPlayer.bird.call_deferred("die")
		return
		
	
	var dth_particles: CPUParticles2D = load("res://entitites/death_particles.tscn").instantiate()
	dth_particles.position = at_pos
	add_child(dth_particles)
	dth_particles.play(type)
	
	var player: Player
	if type == 1:
		player = $Player1Stuff/PinkPlayer
	elif type == 2:
		player = $Player2Stuff/BluePlayer
	
	player.visible = false
	player.global_position = $SpawnPoint.global_position
	player.visible = true
	


func _on_key_picked_up() -> void:
	call_deferred("p")

func p() -> void:
	LOCKED.get_node("CollisionShape2D").disabled = true
	LOCKED.get_node("CPUParticles2D").emitting = true
	LOCKED.get_node("Lock").visible = false
	LOCKED.get_node("ColorRect").modulate = Color(0, 0, 0, 0)
